extends CanvasLayer

@onready var score_label: Label = $HUD/ScoreLabel
@onready var coins_label: Label = $HUD/CoinsLabel
@onready var speed_label: Label = $HUD/SpeedLabel
@onready var game_over_panel: Panel = $HUD/GameOverPanel

func _ready() -> void:
	if game_over_panel:
		game_over_panel.visible = false
	GameManager.game_over_triggered.connect(_on_game_over)

func _process(_delta: float) -> void:
	if score_label:
		score_label.text = "SCORE: %d" % int(GameManager.score)
	if coins_label:
		coins_label.text = "COINS: %d" % GameManager.coins
	if speed_label:
		speed_label.text = "SPEED: %d px/s" % int(GameManager.current_speed)

func _on_game_over() -> void:
	if game_over_panel:
		game_over_panel.visible = true
