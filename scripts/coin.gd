extends Area2D
class_name Coin

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if visible and body is Player:
		GameManager.add_coin()
		visible = false
		set_deferred("process_mode", PROCESS_MODE_DISABLED)
		set_deferred("monitoring", false)
