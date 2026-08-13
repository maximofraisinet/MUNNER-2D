extends CanvasLayer

@onready var score_label: Label = $HUD/ScoreLabel
@onready var coins_label: Label = $HUD/CoinsLabel
@onready var speed_label: Label = $HUD/SpeedLabel

@onready var start_panel: Panel = $StartPanel
@onready var play_button: Button = $StartPanel/PlayButton

@onready var game_over_panel: Panel = $GameOverPanel
@onready var summary_label: Label = $GameOverPanel/SummaryLabel
@onready var restart_button: Button = $GameOverPanel/RestartButton

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	
	start_panel.visible = true
	game_over_panel.visible = false
	
	play_button.pressed.connect(_on_play_button_pressed)
	restart_button.pressed.connect(_on_restart_button_pressed)
	
	GameManager.game_started_triggered.connect(_on_game_started)
	GameManager.game_restarted_triggered.connect(_on_game_restarted)
	GameManager.game_over_triggered.connect(_on_game_over)

func _process(_delta: float) -> void:
	if score_label:
		score_label.text = "SCORE: %d" % int(GameManager.score)
	if coins_label:
		coins_label.text = "COINS: %d" % GameManager.coins
	if speed_label:
		speed_label.text = "SPEED: %d px/s" % int(GameManager.current_speed)

func _on_play_button_pressed() -> void:
	start_panel.visible = false
	game_over_panel.visible = false
	GameManager.start_game()

func _on_restart_button_pressed() -> void:
	start_panel.visible = false
	game_over_panel.visible = false
	GameManager.restart_game()

func _on_game_started() -> void:
	start_panel.visible = false
	game_over_panel.visible = false

func _on_game_restarted() -> void:
	start_panel.visible = false
	game_over_panel.visible = false

func _on_game_over() -> void:
	if summary_label:
		summary_label.text = "Score Final: %d  |  Monedas: %d" % [int(GameManager.score), GameManager.coins]
	game_over_panel.visible = true
