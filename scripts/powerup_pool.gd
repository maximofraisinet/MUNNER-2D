extends Node2D
class_name PowerUpPool

@export var powerup_scene: PackedScene = preload("res://scenes/PowerUp.tscn")

const POOL_SIZE: int = 10
const SPAWN_X: float = 1320.0

var pool: Array[Area2D] = []
var spawn_timer: float = 0.0
var next_spawn_interval: float = 14.0

const HEIGHT_POSITIONS: Array[float] = [540.0, 460.0]

func _ready() -> void:
	GameManager.game_restarted_triggered.connect(reset_pool)
	GameManager.game_started_triggered.connect(reset_pool)
	GameManager.menu_opened_triggered.connect(reset_pool)
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
	next_spawn_interval = randf_range(12.0, 20.0)

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
		next_spawn_interval = randf_range(12.0, 20.0)

func _spawn_powerup() -> void:
	for pup in pool:
		if not pup.visible:
			var rand_type = _select_weighted_powerup_type()
			if pup.has_method("setup"):
				pup.setup(rand_type)
				
			var spawn_y = HEIGHT_POSITIONS[randi() % HEIGHT_POSITIONS.size()]
			pup.global_position = Vector2(SPAWN_X, spawn_y)
			pup.visible = true
			pup.set_deferred("process_mode", PROCESS_MODE_INHERIT)
			pup.set_deferred("monitoring", true)
			return

func _select_weighted_powerup_type() -> PowerUp.Type:
	var curr_char = CharacterManager.get_current_character() if CharacterManager else null
	var life_mult = curr_char.life_spawn_multiplier if curr_char else 1.0
	var fly_mult = curr_char.fly_spawn_multiplier if curr_char else 1.0
	var neg_mult = curr_char.negative_spawn_multiplier if curr_char else 1.0
	
	# Ponderación basada en rareza
	var weights = {
		PowerUp.Type.SHIELD: 40.0,
		PowerUp.Type.TURBO_DEBUFF: 30.0 * neg_mult,
		PowerUp.Type.FLY: 12.0 * fly_mult,
		PowerUp.Type.COIN_MULT_2X: 10.0,
		PowerUp.Type.SLOW_PERMANENT: 8.0,
		PowerUp.Type.EXTRA_LIFE: 6.0 * life_mult,
		PowerUp.Type.SPEED_PERMANENT: 4.0 * neg_mult
	}
	
	var total_weight: float = 0.0
	for w in weights.values():
		total_weight += w
		
	var roll = randf() * total_weight
	var accumulated: float = 0.0
	
	for p_type in weights.keys():
		accumulated += weights[p_type]
		if roll <= accumulated:
			return p_type
			
	return PowerUp.Type.SHIELD

func _deactivate_powerup(pup: Area2D) -> void:
	pup.visible = false
	pup.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	pup.set_deferred("monitoring", false)
