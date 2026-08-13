extends Area2D
class_name Obstacle

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if visible and body is Player:
		if body.has_method("on_obstacle_hit"):
			if body.on_obstacle_hit(self):
				return # El escudo absorbió el golpe y desactivó este obstáculo
		GameManager.game_over()
