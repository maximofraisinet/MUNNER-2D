extends Node

signal game_started_triggered
signal game_over_triggered
signal game_restarted_triggered
signal menu_opened_triggered
signal speed_notification_emitted(message: String, text_color: Color)
signal icon_pack_changed(pack_name: String)
signal background_changed(bg_name: String)
signal ui_theme_changed(theme_name: String)

enum State { START, PLAYING, GAMEOVER }
var current_state: State = State.START

## Parámetros de velocidad iniciales
var initial_speed: float = 400.0
var speed_acceleration: float = 12.0
var current_speed: float = 400.0
var speed_multiplier: float = 1.0

var effective_speed: float:
	get:
		return current_speed * speed_multiplier

## Tiempo de vuelo del jugador
var player_air_hang_time: float = 0.6818

## Configuración de Paquete de Iconos, Fondo y Tema de UI
var selected_icon_pack: String = "default"
var selected_bg: String = "bg-game1"
var selected_ui_theme: String = "light"

## Estadísticas persistentes
var high_score: float = 0.0
var total_coins: int = 0

## Estadísticas de la partida actual
var run_score: float = 0.0
var run_coins: int = 0

const SAVE_PATH = "user://savegame.cfg"

func _ready() -> void:
	load_data()
	get_tree().paused = true

func _process(delta: float) -> void:
	if current_state == State.PLAYING:
		current_speed += speed_acceleration * delta
		run_score += delta * 10.0

func set_icon_pack(pack_name: String) -> void:
	if selected_icon_pack != pack_name:
		selected_icon_pack = pack_name
		save_data()
		icon_pack_changed.emit(selected_icon_pack)

func set_background(bg_name: String) -> void:
	if selected_bg != bg_name:
		selected_bg = bg_name
		save_data()
		background_changed.emit(selected_bg)

func set_ui_theme(theme_name: String) -> void:
	if selected_ui_theme != theme_name:
		selected_ui_theme = theme_name
		save_data()
		ui_theme_changed.emit(selected_ui_theme)

func start_game() -> void:
	current_state = State.PLAYING
	current_speed = initial_speed
	speed_multiplier = 1.0
	run_score = 0.0
	run_coins = 0
	get_tree().paused = false
	game_started_triggered.emit()

func game_over() -> void:
	if current_state == State.GAMEOVER:
		return
	current_state = State.GAMEOVER
	
	total_coins += run_coins
	
	if run_score > high_score:
		high_score = run_score
		
	save_data()
	game_over_triggered.emit()
	get_tree().paused = true

func restart_game() -> void:
	current_state = State.PLAYING
	current_speed = initial_speed
	speed_multiplier = 1.0
	run_score = 0.0
	run_coins = 0
	get_tree().paused = false
	game_restarted_triggered.emit()

func open_main_menu() -> void:
	current_state = State.START
	get_tree().paused = true
	menu_opened_triggered.emit()

func add_coin() -> void:
	run_coins += 1

func apply_permanent_speed_reduction() -> void:
	current_speed = max(250.0, current_speed * 0.80)
	speed_notification_emitted.emit("SPEED DOWN (-20%)", Color(0.0, 1.0, 0.5))

func apply_permanent_speed_increase() -> void:
	current_speed = current_speed * 1.10
	speed_notification_emitted.emit("SPEED UP (+10%)", Color(1.0, 0.5, 0.0))

func save_data() -> void:
	var config = ConfigFile.new()
	config.set_value("stats", "high_score", high_score)
	config.set_value("stats", "total_coins", total_coins)
	config.set_value("settings", "icon_pack", selected_icon_pack)
	config.set_value("settings", "selected_bg", selected_bg)
	config.set_value("settings", "selected_ui_theme", selected_ui_theme)
	config.save(SAVE_PATH)

func load_data() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		high_score = config.get_value("stats", "high_score", 0.0)
		total_coins = config.get_value("stats", "total_coins", 0)
		selected_icon_pack = config.get_value("settings", "icon_pack", "default")
		selected_bg = config.get_value("settings", "selected_bg", "bg-game1")
		selected_ui_theme = config.get_value("settings", "selected_ui_theme", "light")
