extends Node2D
class_name ObstaclePool

@export var obstacle_scene: PackedScene = preload("res://scenes/Obstacle.tscn")

const POOL_SIZE: int = 15
const SPAWN_X: float = 1320.0
const GROUND_Y: float = 558.0

var pool: Array[Area2D] = []
var spawn_timer: float = 0.0
var next_spawn_interval: float = 1.5

var cluster_remaining: int = 0
@onready var coin_pool: Node2D = $"../CoinPool"

func _ready() -> void:
	GameManager.game_restarted_triggered.connect(reset_pool)
	GameManager.game_started_triggered.connect(reset_pool)
	GameManager.menu_opened_triggered.connect(reset_pool)
	for i in range(POOL_SIZE):
		var obs = obstacle_scene.instantiate() as Area2D
		obs.visible = false
		obs.process_mode = PROCESS_MODE_DISABLED
		add_child(obs)
		pool.append(obs)

func reset_pool() -> void:
	for obs in pool:
		_deactivate_obstacle(obs)
	spawn_timer = 0.0
	next_spawn_interval = 1.5
	cluster_remaining = 0

## Desactivar todos los obstáculos en pista de aterrizaje (X entre 0 y 750)
func clear_landing_runway() -> void:
	for obs in pool:
		if obs.visible and obs.global_position.x >= -50.0 and obs.global_position.x <= 750.0:
			_deactivate_obstacle(obs)

func _physics_process(delta: float) -> void:
	if GameManager.current_state != GameManager.State.PLAYING:
		return
		
	var current_speed = GameManager.effective_speed
	
	for obs in pool:
		if obs.visible:
			obs.global_position.x -= current_speed * delta
			if obs.global_position.x < -100.0:
				_deactivate_obstacle(obs)
				
	spawn_timer += delta
	if spawn_timer >= next_spawn_interval:
		spawn_timer = 0.0
		_spawn_obstacle()
		_calculate_next_spawn_interval()

func _spawn_obstacle() -> void:
	for obs in pool:
		if not obs.visible:
			obs.global_position = Vector2(SPAWN_X, GROUND_Y)
			if obs.has_method("randomize_appearance"):
				obs.randomize_appearance()
			obs.visible = true
			obs.process_mode = PROCESS_MODE_INHERIT
			
			if coin_pool and coin_pool.has_method("spawn_coin_over_obstacle") and randf() < 0.35:
				coin_pool.spawn_coin_over_obstacle(SPAWN_X)
			return

func _deactivate_obstacle(obs: Area2D) -> void:
	obs.visible = false
	obs.process_mode = PROCESS_MODE_DISABLED

func _calculate_next_spawn_interval() -> void:
	var v_game = GameManager.effective_speed
	var t_air = GameManager.player_air_hang_time
	
	if cluster_remaining > 0:
		cluster_remaining -= 1
		next_spawn_interval = 0.14
		return

	if randf() < 0.35:
		cluster_remaining = randi_range(1, 2)
	
	var t_react = 0.15
	var distance_clearance = 120.0
	var t_min = t_air + t_react + (distance_clearance / v_game)
	
	next_spawn_interval = t_min + randf_range(0.1, 0.4)
	
	if coin_pool and coin_pool.has_method("spawn_safe_ground_coin") and next_spawn_interval > 1.2 and randf() < 0.4:
		var safe_offset = SPAWN_X + (v_game * next_spawn_interval * 0.5)
		coin_pool.spawn_safe_ground_coin(safe_offset)
