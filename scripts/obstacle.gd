extends Area2D
class_name Obstacle

@onready var sprite: Sprite2D = $Sprite2D

var obstacle_textures: Array[Texture2D] = []

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	_load_textures()

func _load_textures() -> void:
	obstacle_textures.clear()
	var tex1 = load("res://assets/obstacles/obstacle1.png") as Texture2D
	var tex2 = load("res://assets/obstacles/obstacle2.png") as Texture2D
	if tex1: obstacle_textures.append(tex1)
	if tex2: obstacle_textures.append(tex2)

func randomize_appearance() -> void:
	if obstacle_textures.size() == 0:
		_load_textures()
	if sprite and obstacle_textures.size() > 0:
		var tex = obstacle_textures.pick_random()
		sprite.texture = tex
		# Ajustar escala dinámica para alineación visual con el piso y hitbox (34x52)
		if tex:
			var target_height = 52.0
			var scale_factor = target_height / float(tex.get_height())
			sprite.scale = Vector2(scale_factor, scale_factor)

func _on_body_entered(body: Node2D) -> void:
	if visible and body is Player:
		if body.has_method("on_obstacle_hit"):
			if body.on_obstacle_hit(self):
				return # El escudo o vida absorbió el golpe y desactivó este obstáculo
		GameManager.game_over()
