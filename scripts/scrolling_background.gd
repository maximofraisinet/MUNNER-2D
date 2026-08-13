extends Node2D

@export var scroll_speed_ratio: float = 0.4
@onready var sprites: Array[Sprite2D] = [$Sprite1, $Sprite2, $Sprite3]

var scaled_width: float = 0.0

func _ready() -> void:
	z_index = -10
	if GameManager:
		GameManager.background_changed.connect(_on_background_changed)
	_setup_background()

func _on_background_changed(_bg_name: String) -> void:
	_setup_background()

func _setup_background() -> void:
	var bg_name = GameManager.selected_bg if GameManager else "bg-game1"
	var texture_path = "res://assets/backgrounds/%s.png" % bg_name
	var tex = load(texture_path) as Texture2D
	
	if not tex:
		tex = load("res://assets/backgrounds/bg-game1.png") as Texture2D
		
	if tex and sprites.size() > 0:
		var target_height: float = 540.0
		var scale_factor: float = target_height / tex.get_height()
		scaled_width = tex.get_width() * scale_factor
		
		var start_x: float = -400.0
		var target_y: float = 80.0
		
		for i in range(sprites.size()):
			var spr = sprites[i]
			spr.texture = tex
			spr.centered = false
			spr.scale = Vector2(scale_factor, scale_factor)
			spr.modulate = Color.WHITE
			spr.position = Vector2(start_x + (i * scaled_width), target_y)

func _process(delta: float) -> void:
	if GameManager.current_state == GameManager.State.PLAYING:
		var speed = GameManager.effective_speed * scroll_speed_ratio
		
		for spr in sprites:
			spr.position.x -= speed * delta
			
		for spr in sprites:
			if spr.position.x + scaled_width < -400.0:
				var rightmost_x = _get_rightmost_x()
				spr.position.x = rightmost_x + scaled_width

func _get_rightmost_x() -> float:
	var max_x = -99999.0
	for spr in sprites:
		if spr.position.x > max_x:
			max_x = spr.position.x
	return max_x
