extends Area2D
class_name PowerUp

enum Type { SHIELD, FLY, TURBO_DEBUFF, EXTRA_LIFE }

var type: Type = Type.SHIELD
@onready var visual: ColorRect = $Visual

func setup(p_type: Type) -> void:
	type = p_type
	if visual:
		match type:
			Type.SHIELD:
				visual.color = Color(0.0, 1.0, 1.0, 1.0) # Cian Neón
			Type.FLY:
				visual.color = Color(1.0, 0.84, 0.0, 1.0) # Dorado
			Type.TURBO_DEBUFF:
				visual.color = Color(1.0, 0.0, 1.0, 1.0) # Púrpura
			Type.EXTRA_LIFE:
				visual.color = Color(1.0, 0.15, 0.25, 1.0) # Rojo Corazón

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if visible and body is Player:
		body.apply_powerup(type)
		visible = false
		set_deferred("process_mode", PROCESS_MODE_DISABLED)
		set_deferred("monitoring", false)
