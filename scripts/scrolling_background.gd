extends Node2D

@export var scroll_speed_ratio: float = 0.4
@onready var sprites: Array[Sprite2D] = [$Sprite1, $Sprite2, $Sprite3]

var scaled_width: float = 0.0

func _ready() -> void:
	z_index = -10
	_setup_background()

func _setup_background() -> void:
	if sprites.size() > 0 and sprites[0] and sprites[0].texture:
		var target_height: float = 540.0
		var scale_factor: float = target_height / sprites[0].texture.get_height()
		scaled_width = sprites[0].texture.get_width() * scale_factor
		
		# Posición inicial de la cámara: X=500, Zoom=1.2 => Borde izquierdo X = 20
		var start_x: float = -400.0
		var target_y: float = 80.0 # Posición Y del borde superior del viewport
		
		for i in range(sprites.size()):
			var spr = sprites[i]
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
			# Si el borde derecho de un sprite sale por completo del área visible izquierda
			if spr.position.x + scaled_width < -400.0:
				var rightmost_x = _get_rightmost_x()
				spr.position.x = rightmost_x + scaled_width

func _get_rightmost_x() -> float:
	var max_x = -99999.0
	for spr in sprites:
		if spr.position.x > max_x:
			max_x = spr.position.x
	return max_x
