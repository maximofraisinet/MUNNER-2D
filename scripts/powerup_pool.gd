extends Node2D
class_name PowerUpPool

@export var powerup_scene: PackedScene = preload("res://scenes/PowerUp.tscn")

const POOL_SIZE: int = 8
const SPAWN_X: float = 1320.0

var pool: Array[Area2D] = []
var spawn_timer: float = 0.0
var next_spawn_interval: float = 10.0

const HEIGHT_POSITIONS: Array[float] = [540.0, 460.0]

func _ready() -> void:
	GameManager.game_restarted_triggered.connect(reset_pool)
	for i in range(POOL_SIZE):
		var pup = powerup_scene.instantiate() as Area2D
		pup.visible = false
		pup.process_mode = PROCESS_MODE_DISABLED
		pup.monitoring = false
		add_child(pup)
		pool.append(pup)

func reset_pool() -> void:
	for pup in pool:
		_deactivate_powerup(pup)
	spawn_timer = 0.0
	next_spawn_interval = randf_range(7.0, 12.0)

func _physics_process(delta: float) -> void:
	if GameManager.current_state != GameManager.State.PLAYING:
		return
		
	var current_speed = GameManager.effective_speed
	
	for pup in pool:
		if pup.visible:
			pup.global_position.x -= current_speed * delta
			if pup.global_position.x < -100.0:
				_deactivate_powerup(pup)
				
	spawn_timer += delta
	if spawn_timer >= next_spawn_interval:
		spawn_timer = 0.0
		_spawn_powerup()
		next_spawn_interval = randf_range(7.0, 12.0)

func _spawn_powerup() -> void:
	for pup in pool:
		if not pup.visible:
			var rand_type = randi() % 4 as PowerUp.Type
			if pup.has_method("setup"):
				pup.setup(rand_type)
				
			var spawn_y = HEIGHT_POSITIONS[randi() % HEIGHT_POSITIONS.size()]
			pup.global_position = Vector2(SPAWN_X, spawn_y)
			pup.visible = true
			pup.set_deferred("process_mode", PROCESS_MODE_INHERIT)
			pup.set_deferred("monitoring", true)
			return

func _deactivate_powerup(pup: Area2D) -> void:
	pup.visible = false
	pup.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	pup.set_deferred("monitoring", false)
