extends Node

signal game_started_triggered
signal game_over_triggered
signal game_restarted_triggered

enum State { START, PLAYING, GAMEOVER }
var current_state: State = State.START

## Parámetros de velocidad iniciales
var initial_speed: float = 400.0
var speed_acceleration: float = 12.0
var current_speed: float = 400.0

## Tiempo de vuelo del jugador
var player_air_hang_time: float = 0.6818

## Estado del juego
var score: float = 0.0
var coins: int = 0

func _ready() -> void:
	# El juego inicia pausado a la espera del botón PLAY
	get_tree().paused = true

func _process(delta: float) -> void:
	if current_state == State.PLAYING:
		current_speed += speed_acceleration * delta
		score += delta * 10.0
	elif current_state == State.GAMEOVER:
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
			restart_game()

func start_game() -> void:
	current_state = State.PLAYING
	current_speed = initial_speed
	score = 0.0
	coins = 0
	get_tree().paused = false
	game_started_triggered.emit()

func game_over() -> void:
	if current_state == State.GAMEOVER:
		return
	current_state = State.GAMEOVER
	game_over_triggered.emit()
	get_tree().paused = true

func restart_game() -> void:
	current_state = State.PLAYING
	current_speed = initial_speed
	score = 0.0
	coins = 0
	get_tree().paused = false
	game_restarted_triggered.emit()

func add_coin() -> void:
	coins += 1
