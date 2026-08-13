extends Area2D

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if GameManager:
		GameManager.icon_pack_changed.connect(_on_icon_pack_changed)
	_update_texture()

func _on_icon_pack_changed(_new_pack: String) -> void:
	_update_texture()

func _update_texture() -> void:
	if not sprite:
		return
	var pack_name = GameManager.selected_icon_pack if GameManager else "argento"
	var path = "res://assets/powerups/%s/coin.png" % pack_name
	var tex = load(path) as Texture2D
	if not tex:
		tex = load("res://assets/ui/coin.png") as Texture2D
	if tex:
		sprite.texture = tex
		var max_side = max(tex.get_width(), tex.get_height())
		if max_side > 0:
			var s = 32.0 / max_side
			sprite.scale = Vector2(s, s)

func _on_body_entered(body: Node2D) -> void:
	if visible and body is Player:
		GameManager.add_coin()
		visible = false
		set_deferred("process_mode", PROCESS_MODE_DISABLED)
		set_deferred("monitoring", false)
