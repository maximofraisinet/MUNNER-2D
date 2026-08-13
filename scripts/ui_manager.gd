extends CanvasLayer

@onready var hud: Control = $HUD
@onready var score_label: Label = $HUD/ScoreLabel
@onready var coins_label: Label = $HUD/CoinsLabel
@onready var speed_label: Label = $HUD/SpeedLabel

@onready var main_menu: Control = $MainMenu
@onready var best_score_label: Label = $MainMenu/StatsContainer/BestScoreLabel
@onready var total_coins_label: Label = $MainMenu/StatsContainer/TotalCoinsLabel
@onready var play_button: Button = $MainMenu/ButtonsContainer/PlayButton
@onready var store_button: Button = $MainMenu/ButtonsContainer/StoreButton
@onready var exit_button: Button = $MainMenu/ButtonsContainer/ExitButton

@onready var store_panel: Panel = $StorePanel
@onready var select_demon_button: Button = $StorePanel/CharactersHBox/DemonBox/SelectDemonButton
@onready var select_tired_button: Button = $StorePanel/CharactersHBox/TiredBox/SelectTiredButton
@onready var select_leech_button: Button = $StorePanel/CharactersHBox/LeechBox/SelectLeechButton
@onready var close_store_button: Button = $StorePanel/CloseStoreButton

@onready var game_over_panel: Panel = $GameOverPanel
@onready var summary_label: Label = $GameOverPanel/SummaryLabel
@onready var restart_button: Button = $GameOverPanel/ButtonsContainer/RestartButton
@onready var menu_button: Button = $GameOverPanel/ButtonsContainer/MenuButton

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	
	_show_main_menu()
	
	play_button.pressed.connect(_on_play_button_pressed)
	store_button.pressed.connect(_on_store_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	
	select_demon_button.pressed.connect(_on_select_demon_pressed)
	select_tired_button.pressed.connect(_on_select_tired_pressed)
	select_leech_button.pressed.connect(_on_select_leech_pressed)
	close_store_button.pressed.connect(_on_close_store_button_pressed)
	
	restart_button.pressed.connect(_on_restart_button_pressed)
	menu_button.pressed.connect(_on_menu_button_pressed)
	
	GameManager.game_started_triggered.connect(_on_game_started)
	GameManager.game_restarted_triggered.connect(_on_game_restarted)
	GameManager.menu_opened_triggered.connect(_on_menu_opened)
	GameManager.game_over_triggered.connect(_on_game_over)

func _process(_delta: float) -> void:
	if score_label:
		score_label.text = "SCORE: %d" % int(GameManager.run_score)
	if coins_label:
		coins_label.text = "COINS: %d" % GameManager.run_coins
	if speed_label:
		speed_label.text = "SPEED: %d px/s" % int(GameManager.current_speed)

func _update_store_buttons() -> void:
	var current_id = CharacterManager.current_character_id if CharacterManager else "demon"
	
	# DEMON
	select_demon_button.text = "EQUIPPED" if current_id == "demon" else "SELECT"
	select_demon_button.disabled = (current_id == "demon")
	
	# TIRED
	select_tired_button.text = "EQUIPPED" if current_id == "tired" else "SELECT"
	select_tired_button.disabled = (current_id == "tired")
	
	# LEECH
	select_leech_button.text = "EQUIPPED" if current_id == "leech" else "SELECT"
	select_leech_button.disabled = (current_id == "leech")

func _update_menu_stats() -> void:
	if best_score_label:
		best_score_label.text = "BEST SCORE: %d" % int(GameManager.high_score)
	if total_coins_label:
		total_coins_label.text = "TOTAL COINS: %d" % GameManager.total_coins

func _show_main_menu() -> void:
	_update_menu_stats()
	_update_store_buttons()
	main_menu.visible = true
	hud.visible = false
	game_over_panel.visible = false
	store_panel.visible = false

func _on_play_button_pressed() -> void:
	main_menu.visible = false
	hud.visible = true
	GameManager.start_game()

func _on_store_button_pressed() -> void:
	_update_store_buttons()
	store_panel.visible = true

func _on_select_demon_pressed() -> void:
	if CharacterManager:
		CharacterManager.select_character("demon")
		_update_store_buttons()

func _on_select_tired_pressed() -> void:
	if CharacterManager:
		CharacterManager.select_character("tired")
		_update_store_buttons()

func _on_select_leech_pressed() -> void:
	if CharacterManager:
		CharacterManager.select_character("leech")
		_update_store_buttons()

func _on_close_store_button_pressed() -> void:
	store_panel.visible = false

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_restart_button_pressed() -> void:
	main_menu.visible = false
	game_over_panel.visible = false
	hud.visible = true
	GameManager.restart_game()

func _on_menu_button_pressed() -> void:
	GameManager.open_main_menu()

func _on_game_started() -> void:
	main_menu.visible = false
	game_over_panel.visible = false
	store_panel.visible = false
	hud.visible = true

func _on_game_restarted() -> void:
	main_menu.visible = false
	game_over_panel.visible = false
	store_panel.visible = false
	hud.visible = true

func _on_menu_opened() -> void:
	_show_main_menu()

func _on_game_over() -> void:
	if summary_label:
		summary_label.text = "Final Score: %d  |  Coins: %d" % [int(GameManager.run_score), GameManager.run_coins]
	game_over_panel.visible = true
