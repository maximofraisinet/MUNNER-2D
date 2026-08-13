extends Node2D
class_name CoinPool

@export var coin_scene: PackedScene = preload("res://scenes/Coin.tscn")

const POOL_SIZE: int = 10
var pool: Array[Area2D] = []

func _ready() -> void:
	GameManager.game_restarted_triggered.connect(reset_pool)
	for i in range(POOL_SIZE):
		var coin = coin_scene.instantiate() as Area2D
		coin.visible = false
		coin.process_mode = PROCESS_MODE_DISABLED
		coin.monitoring = false
		add_child(coin)
		pool.append(coin)

func reset_pool() -> void:
	for coin in pool:
		_deactivate_coin(coin)

func _physics_process(delta: float) -> void:
	if GameManager.current_state != GameManager.State.PLAYING:
		return
		
	var current_speed = GameManager.current_speed
	
	for coin in pool:
		if coin.visible:
			coin.global_position.x -= current_speed * delta
			if coin.global_position.x < -100.0:
				_deactivate_coin(coin)

func spawn_coin_over_obstacle(obstacle_x: float) -> void:
	var coin = _get_free_coin()
	if coin:
		coin.global_position = Vector2(obstacle_x, 425.0)
		coin.visible = true
		coin.set_deferred("process_mode", PROCESS_MODE_INHERIT)
		coin.set_deferred("monitoring", true)

func spawn_safe_ground_coin(spawn_x: float) -> void:
	var coin = _get_free_coin()
	if coin:
		coin.global_position = Vector2(spawn_x, 540.0)
		coin.visible = true
		coin.set_deferred("process_mode", PROCESS_MODE_INHERIT)
		coin.set_deferred("monitoring", true)

func _get_free_coin() -> Area2D:
	for coin in pool:
		if not coin.visible:
			return coin
	return null

func _deactivate_coin(coin: Area2D) -> void:
	coin.visible = false
	coin.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	coin.set_deferred("monitoring", false)
