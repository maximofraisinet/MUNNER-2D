extends Node2D

@export var scroll_speed_ratio: float = 0.4
@onready var sprites: Array[Sprite2D] = [$Sprite1, $Sprite2, $Sprite3]
@onready var ground_color_rect: ColorRect = $"../Ground/ColorRect"

var scaled_width: float = 0.0

func _ready() -> void:
	z_index = -10
	if GameManager:
		GameManager.background_changed.connect(_on_background_changed)
		GameManager.game_started_triggered.connect(_setup_background)
		GameManager.game_restarted_triggered.connect(_setup_background)
		GameManager.menu_opened_triggered.connect(_setup_background)
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
			
	_update_ground_color(bg_name)

func _update_ground_color(bg_name: String) -> void:
	if not ground_color_rect:
		return
	match bg_name:
		"bg-game2":
			ground_color_rect.color = Color(0.101961, 0.250980, 0.152941, 1.0) # 1A4027FF
		"bg-game3":
			ground_color_rect.color = Color(0.007843, 0.007843, 0.015686, 1.0) # 020204FF
		"bg-black":
			ground_color_rect.color = Color(0.18, 0.18, 0.18, 1.0)
		"bg-white":
			ground_color_rect.color = Color(0.75, 0.75, 0.75, 1.0)
		_: # bg-game1 / default
			ground_color_rect.color = Color(0.588235, 0.905882, 0.266667, 1.0) # 96E744FF

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
