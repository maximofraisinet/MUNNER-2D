extends CharacterBody2D
class_name Player

@export var gravity: float = 2200.0
@export var jump_velocity: float = -750.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var obstacle_pool: Node2D = $"../ObstaclePool"
@onready var coin_pool: Node2D = $"../CoinPool"

var air_hang_time: float:
	get:
		return (2.0 * abs(jump_velocity)) / gravity

var current_character: CharacterData
var anim_timer: float = 0.0
var current_frame_idx: int = 0
var anim_fps: float = 12.0
var initial_pos: Vector2 = Vector2(100, 545)

## ESTADOS DE POTENCIADORES Y VIDAS
var extra_lives: int = 0

var has_shield: bool = false
var shield_timer: float = 0.0
var shield_regen_timer: float = 0.0

var is_invulnerable: bool = false
var invulnerability_timer: float = 0.0

var is_flying: bool = false
var fly_timer: float = 0.0
var coin_trail_timer: float = 0.0

var is_turbo: bool = false
var turbo_timer: float = 0.0

func _ready() -> void:
	initial_pos = global_position
	GameManager.game_restarted_triggered.connect(_on_game_restarted)
	GameManager.game_started_triggered.connect(_on_game_started)
	if CharacterManager:
		CharacterManager.character_changed.connect(_on_character_changed)
	load_character()

func _on_game_started() -> void:
	_reset_player_state()

func _on_game_restarted() -> void:
	_reset_player_state()

func _reset_player_state() -> void:
	global_position = initial_pos
	velocity = Vector2.ZERO
	extra_lives = 0
	has_shield = false
	shield_timer = 0.0
	shield_regen_timer = 0.0
	is_invulnerable = false
	invulnerability_timer = 0.0
	is_flying = false
	fly_timer = 0.0
	is_turbo = false
	turbo_timer = 0.0
	GameManager.speed_multiplier = 1.0
	
	if current_character and current_character.id == "demon_messi":
		extra_lives = 5 # Empieza con 5 vidas extra
		has_shield = true
		shield_timer = 999999.0 # Escudo permanente inicial
		
	if sprite:
		sprite.modulate = Color.WHITE

func _on_character_changed(_new_char: CharacterData) -> void:
	load_character()

func load_character() -> void:
	if CharacterManager:
		current_character = CharacterManager.get_current_character()
		if current_character and sprite:
			sprite.scale = current_character.sprite_scale
			sprite.position = current_character.sprite_offset
			if current_character.run_frames.size() > 0:
				sprite.texture = current_character.run_frames[0]
				current_frame_idx = 0

func apply_powerup(type: PowerUp.Type) -> void:
	match type:
		PowerUp.Type.SHIELD:
			has_shield = true
			var shield_dur = 6.0 if (current_character and current_character.id == "leech") else 5.0
			shield_timer = 999999.0 if (current_character and current_character.id == "demon_messi") else shield_dur
		PowerUp.Type.EXTRA_LIFE:
			extra_lives += 1
		PowerUp.Type.FLY:
			is_flying = true
			fly_timer = 4.0
		PowerUp.Type.TURBO_DEBUFF:
			if current_character and (current_character.id == "messi" or current_character.id == "demon_messi"):
				return # Inmune a debuffs
			is_turbo = true
			turbo_timer = 4.0
			GameManager.speed_multiplier = 1.35
		PowerUp.Type.SLOW_PERMANENT:
			GameManager.apply_permanent_speed_reduction()
		PowerUp.Type.SPEED_PERMANENT:
			if current_character and (current_character.id == "messi" or current_character.id == "demon_messi"):
				return # Inmune a aceleración negativa
			GameManager.apply_permanent_speed_increase()

func use_boost_slot(slot_idx: int) -> void:
	if not CharacterManager: return
	var curr_char = CharacterManager.get_current_character()
	if not curr_char or slot_idx >= curr_char.boost_slots:
		return
	var boost_id = CharacterManager.equipped_boost_slots[slot_idx]
	if boost_id != "" and CharacterManager.get_boost_qty(boost_id) > 0:
		CharacterManager.boost_inventory[boost_id] -= 1
		CharacterManager.save_data()
		CharacterManager.boost_inventory_changed.emit()
		
		if boost_id == "shield_boost":
			has_shield = true
			shield_timer = 999999.0 if (curr_char.id == "demon_messi") else 5.0
			GameManager.speed_notification_emitted.emit("ACTIVATED SHIELD BOOST!", Color(0.0, 1.0, 1.0))
		elif boost_id == "life_boost":
			extra_lives += 1
			GameManager.speed_notification_emitted.emit("ACTIVATED LIFE BOOST!", Color(1.0, 0.2, 0.3))
		elif boost_id == "slow_boost":
			GameManager.apply_permanent_speed_reduction()
		elif boost_id == "fly_boost":
			is_flying = true
			fly_timer = 4.0
			GameManager.speed_notification_emitted.emit("ACTIVATED FLY BOOST!", Color(1.0, 0.84, 0.0))

func on_obstacle_hit(obs: Area2D) -> bool:
	if is_invulnerable:
		return true
		
	# 1. Absorber con Escudo
	if has_shield:
		has_shield = false
		shield_timer = 0.0
		is_invulnerable = true
		invulnerability_timer = 0.5
		if current_character and current_character.id == "demon_messi":
			shield_regen_timer = 2.0 # Se auto-regenera en 2 segundos
		if obs:
			obs.visible = false
			obs.set_deferred("process_mode", PROCESS_MODE_DISABLED)
		return true
		
	# 2. Resucitar con Vida Extra acumulada
	if extra_lives > 0:
		extra_lives -= 1
		is_invulnerable = true
		invulnerability_timer = 1.5
		if obs:
			obs.visible = false
			obs.set_deferred("process_mode", PROCESS_MODE_DISABLED)
		if obstacle_pool and obstacle_pool.has_method("clear_landing_runway"):
			obstacle_pool.clear_landing_runway()
		return true
		
	return false

func _unhandled_input(event: InputEvent) -> void:
	if GameManager.current_state == GameManager.State.PLAYING and event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_1:
			use_boost_slot(0)
		elif event.keycode == KEY_2:
			use_boost_slot(1)
		elif event.keycode == KEY_3:
			use_boost_slot(2)

func _physics_process(delta: float) -> void:
	if GameManager.current_state != GameManager.State.PLAYING:
		return

	# Procesar temporizador de invulnerabilidad
	if is_invulnerable:
		invulnerability_timer -= delta
		if invulnerability_timer <= 0.0:
			is_invulnerable = false

	# Regenerar escudo de DEMON MESSI
	if shield_regen_timer > 0.0:
		shield_regen_timer -= delta
		if shield_regen_timer <= 0.0:
			has_shield = true
			shield_timer = 999999.0

	# Procesar temporizador de Escudo Finito
	if has_shield and current_character and current_character.id != "demon_messi":
		shield_timer -= delta
		if shield_timer <= 0.0:
			has_shield = false

	# Procesar temporizador de Turbo
	if is_turbo:
		turbo_timer -= delta
		if turbo_timer <= 0.0:
			is_turbo = false
			GameManager.speed_multiplier = 1.0

	# Imán de Monedas para DEMON MESSI
	if current_character and current_character.id == "demon_messi":
		_process_coin_magnet(delta)

	# Procesar temporizador de Vuelo
	if is_flying:
		fly_timer -= delta
		velocity.y = 0.0
		global_position.y = lerp(global_position.y, 380.0, 8.0 * delta)
		
		coin_trail_timer += delta
		if coin_trail_timer >= 0.25:
			coin_trail_timer = 0.0
			if coin_pool and coin_pool.has_method("spawn_flight_coin"):
				coin_pool.spawn_flight_coin(1180.0, 360.0)
				
		if fly_timer <= 0.0:
			is_flying = false
			if obstacle_pool and obstacle_pool.has_method("clear_landing_runway"):
				obstacle_pool.clear_landing_runway()
	else:
		if not is_on_floor():
			velocity.y += gravity * delta
			if current_character and current_character.jump_frame and sprite:
				sprite.texture = current_character.jump_frame
		else:
			_animate_run(delta)

		if is_on_floor() and (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")):
			velocity.y = jump_velocity

	_update_visual_modulation()
	move_and_slide()

func _process_coin_magnet(delta: float) -> void:
	if not coin_pool: return
	for coin in coin_pool.get_children():
		if coin is Area2D and coin.visible:
			var dist = global_position.distance_to(coin.global_position)
			if dist < 600.0:
				coin.global_position = coin.global_position.move_toward(global_position, 800.0 * delta)

func _update_visual_modulation() -> void:
	if not sprite:
		return
		
	if is_flying:
		sprite.modulate = Color(1.0, 0.85, 0.3)
	elif is_turbo:
		sprite.modulate = Color(1.0, 0.4, 1.0)
	elif has_shield:
		sprite.modulate = Color(0.4, 1.0, 1.0)
	elif is_invulnerable:
		sprite.modulate = Color(1.0, 0.5, 0.5, 0.7)
	else:
		sprite.modulate = Color.WHITE

func _animate_run(delta: float) -> void:
	if not current_character or current_character.run_frames.size() == 0 or not sprite:
		return
		
	var speed_multiplier = GameManager.effective_speed / 400.0
	anim_timer += delta * anim_fps * speed_multiplier
	
	if anim_timer >= 1.0:
		anim_timer -= 1.0
		current_frame_idx = (current_frame_idx + 1) % current_character.run_frames.size()
		sprite.texture = current_character.run_frames[current_frame_idx]
