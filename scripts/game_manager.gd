extends Node

signal game_over_triggered

## Velocidad incremental infinita
var initial_speed: float = 400.0
var speed_acceleration: float = 12.0
var current_speed: float = 400.0

## Tiempo de vuelo del jugador
var player_air_hang_time: float = 0.6818

## Estado del juego
var score: float = 0.0
var coins: int = 0
var is_game_over: bool = false

func _ready() -> void:
	reset_game()

func _process(delta: float) -> void:
	if is_game_over:
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
			get_tree().paused = false
			get_tree().reload_current_scene()
			reset_game()
		return
		
	# Incrementar velocidad gradualmente de forma infinita con el paso del tiempo
	current_speed += speed_acceleration * delta
	
	# Incrementar puntaje según tiempo sobrevivido
	score += delta * 10.0

func add_coin() -> void:
	coins += 1

func reset_game() -> void:
	current_speed = initial_speed
	score = 0.0
	coins = 0
	is_game_over = false

func game_over() -> void:
	if is_game_over:
		return
	is_game_over = true
	game_over_triggered.emit()
	get_tree().paused = true
