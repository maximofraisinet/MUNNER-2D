extends CharacterBody2D
class_name Player

@export var gravity: float = 2200.0
@export var jump_velocity: float = -750.0

@onready var sprite: Sprite2D = $Sprite2D

var air_hang_time: float:
	get:
		return (2.0 * abs(jump_velocity)) / gravity

var current_character: CharacterData
var anim_timer: float = 0.0
var current_frame_idx: int = 0
var anim_fps: float = 12.0
var initial_pos: Vector2 = Vector2(100, 545)

func _ready() -> void:
	initial_pos = global_position
	GameManager.game_restarted_triggered.connect(_on_game_restarted)
	load_character()

func _on_game_restarted() -> void:
	global_position = initial_pos
	velocity = Vector2.ZERO

func load_character() -> void:
	if CharacterManager:
		current_character = CharacterManager.get_current_character()
		if current_character and sprite:
			sprite.scale = current_character.sprite_scale
			sprite.position = current_character.sprite_offset
			if current_character.run_frames.size() > 0:
				sprite.texture = current_character.run_frames[0]

func _physics_process(delta: float) -> void:
	if GameManager.current_state != GameManager.State.PLAYING:
		return

	if not is_on_floor():
		velocity.y += gravity * delta
		if current_character and current_character.jump_frame and sprite:
			sprite.texture = current_character.jump_frame
	else:
		_animate_run(delta)

	if is_on_floor() and (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")):
		velocity.y = jump_velocity

	move_and_slide()

func _animate_run(delta: float) -> void:
	if not current_character or current_character.run_frames.size() == 0 or not sprite:
		return
		
	var speed_multiplier = GameManager.current_speed / 400.0
	anim_timer += delta * anim_fps * speed_multiplier
	
	if anim_timer >= 1.0:
		anim_timer -= 1.0
		current_frame_idx = (current_frame_idx + 1) % current_character.run_frames.size()
		sprite.texture = current_character.run_frames[current_frame_idx]
