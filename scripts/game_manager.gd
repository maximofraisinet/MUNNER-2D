extends Node

signal game_started_triggered
signal game_over_triggered
signal game_restarted_triggered
signal menu_opened_triggered

enum State { START, PLAYING, GAMEOVER }
var current_state: State = State.START

## Parámetros de velocidad iniciales
var initial_speed: float = 400.0
var speed_acceleration: float = 12.0
var current_speed: float = 400.0

## Tiempo de vuelo del jugador
var player_air_hang_time: float = 0.6818

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

func start_game() -> void:
	current_state = State.PLAYING
	current_speed = initial_speed
	run_score = 0.0
	run_coins = 0
	get_tree().paused = false
	game_started_triggered.emit()

func game_over() -> void:
	if current_state == State.GAMEOVER:
		return
	current_state = State.GAMEOVER
	
	# Acumular monedas de esta partida al total persistente
	total_coins += run_coins
	
	# Actualizar High Score si se superó el récord
	if run_score > high_score:
		high_score = run_score
		
	save_data()
	game_over_triggered.emit()
	get_tree().paused = true

func restart_game() -> void:
	current_state = State.PLAYING
	current_speed = initial_speed
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

func save_data() -> void:
	var config = ConfigFile.new()
	config.set_value("stats", "high_score", high_score)
	config.set_value("stats", "total_coins", total_coins)
	config.save(SAVE_PATH)

func load_data() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		high_score = config.get_value("stats", "high_score", 0.0)
		total_coins = config.get_value("stats", "total_coins", 0)
