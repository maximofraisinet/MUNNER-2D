extends Area2D
class_name PowerUp

enum Type { SHIELD, FLY, TURBO_DEBUFF, EXTRA_LIFE, SLOW_PERMANENT, SPEED_PERMANENT }

var type: Type = Type.SHIELD
@onready var visual: ColorRect = $Visual
@onready var icon_sprite: Sprite2D = $IconSprite

func setup(p_type: Type) -> void:
	type = p_type
	_update_visuals()

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if GameManager:
		GameManager.icon_pack_changed.connect(_on_icon_pack_changed)

func _on_icon_pack_changed(_new_pack: String) -> void:
	_update_visuals()

func _update_visuals() -> void:
	if not visual:
		return
		
	var pack_name = GameManager.selected_icon_pack if GameManager else "argento"
	var icon_name: String = ""
	var default_color: Color = Color.WHITE
	
	match type:
		Type.SHIELD:
			icon_name = "shield.png"
			default_color = Color(0.0, 1.0, 1.0, 1.0)
		Type.FLY:
			icon_name = "fly.png"
			default_color = Color(1.0, 0.84, 0.0, 1.0)
		Type.TURBO_DEBUFF:
			icon_name = "turbo.png"
			default_color = Color(1.0, 0.0, 1.0, 1.0)
		Type.EXTRA_LIFE:
			icon_name = "life.png"
			default_color = Color(1.0, 0.15, 0.25, 1.0)
		Type.SLOW_PERMANENT:
			icon_name = "slow.png"
			default_color = Color(0.0, 1.0, 0.5, 1.0)
		Type.SPEED_PERMANENT:
			icon_name = "speed.png"
			default_color = Color(1.0, 0.5, 0.0, 1.0)

	visual.color = default_color
	
	var texture_path = "res://assets/powerups/%s/%s" % [pack_name, icon_name]
	var tex = load(texture_path) as Texture2D
	
	if tex and icon_sprite:
		icon_sprite.texture = tex
		icon_sprite.visible = true
		
		# Ajustar escala para encajar dentro del área del potenciador (~36x36 px)
		var max_side = max(tex.get_width(), tex.get_height())
		if max_side > 0:
			var s = 36.0 / max_side
			icon_sprite.scale = Vector2(s, s)
			
		visual.visible = false # Ocultar rect de fallback cuando hay textura
	else:
		if icon_sprite:
			icon_sprite.visible = false
		visual.visible = true

func _on_body_entered(body: Node2D) -> void:
	if visible and body is Player:
		body.apply_powerup(type)
		visible = false
		set_deferred("process_mode", PROCESS_MODE_DISABLED)
		set_deferred("monitoring", false)
