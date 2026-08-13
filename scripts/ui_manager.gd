extends CanvasLayer

@onready var hud: Control = $HUD
@onready var score_label: Label = $HUD/ScoreLabel
@onready var coins_label: Label = $HUD/CoinsLabel
@onready var speed_label: Label = $HUD/SpeedLabel

@onready var lives_status_label: Label = $HUD/PowerUpStatusBox/LivesStatusLabel
@onready var shield_status_label: Label = $HUD/PowerUpStatusBox/ShieldStatusLabel
@onready var fly_status_label: Label = $HUD/PowerUpStatusBox/FlyStatusLabel
@onready var turbo_status_label: Label = $HUD/PowerUpStatusBox/TurboStatusLabel

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
@onready var select_maximo_button: Button = $StorePanel/CharactersHBox/MaximoBox/SelectMaximoButton
@onready var select_omablo_button: Button = $StorePanel/CharactersHBox/OmabloBox/SelectOmabloButton
@onready var close_store_button: Button = $StorePanel/CloseStoreButton

@onready var game_over_panel: Panel = $GameOverPanel
@onready var summary_label: Label = $GameOverPanel/SummaryLabel
@onready var restart_button: Button = $GameOverPanel/ButtonsContainer/RestartButton
@onready var menu_button: Button = $GameOverPanel/ButtonsContainer/MenuButton

@onready var player: Node2D = $"../Player"

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	
	_show_main_menu()
	
	play_button.pressed.connect(_on_play_button_pressed)
	store_button.pressed.connect(_on_store_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	
	select_demon_button.pressed.connect(_on_select_demon_pressed)
	select_tired_button.pressed.connect(_on_select_tired_pressed)
	select_leech_button.pressed.connect(_on_select_leech_pressed)
	select_maximo_button.pressed.connect(_on_select_maximo_pressed)
	select_omablo_button.pressed.connect(_on_select_omablo_pressed)
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
		speed_label.text = "SPEED: %d px/s" % int(GameManager.effective_speed)

	_update_powerup_status()

func _update_powerup_status() -> void:
	if not player:
		return
		
	# Lives Status (Top Right)
	if lives_status_label:
		var lives = int(player.get("extra_lives"))
		lives_status_label.visible = (lives > 0)
		if lives > 0:
			lives_status_label.text = "LIVES: %d" % lives

	# Finite Shield Status (5s Timer)
	if shield_status_label:
		var has_shield = player.get("has_shield") == true
		shield_status_label.visible = has_shield
		if has_shield:
			shield_status_label.text = "SHIELD: %.1fs" % float(player.get("shield_timer"))
		
	# Fly Status
	if fly_status_label:
		var is_flying = player.get("is_flying") == true
		fly_status_label.visible = is_flying
		if is_flying:
			fly_status_label.text = "FLYING: %.1fs" % float(player.get("fly_timer"))
			
	# Turbo Status
	if turbo_status_label:
		var is_turbo = player.get("is_turbo") == true
		turbo_status_label.visible = is_turbo
		if is_turbo:
			turbo_status_label.text = "TURBO DEBUFF: %.1fs" % float(player.get("turbo_timer"))

func _update_store_buttons() -> void:
	var current_id = CharacterManager.current_character_id if CharacterManager else "demon"
	
	select_demon_button.text = "EQUIPPED" if current_id == "demon" else "SELECT"
	select_demon_button.disabled = (current_id == "demon")
	
	select_tired_button.text = "EQUIPPED" if current_id == "tired" else "SELECT"
	select_tired_button.disabled = (current_id == "tired")
	
	select_leech_button.text = "EQUIPPED" if current_id == "leech" else "SELECT"
	select_leech_button.disabled = (current_id == "leech")
	
	select_maximo_button.text = "EQUIPPED" if current_id == "maximo" else "SELECT"
	select_maximo_button.disabled = (current_id == "maximo")
	
	select_omablo_button.text = "EQUIPPED" if current_id == "omablo" else "SELECT"
	select_omablo_button.disabled = (current_id == "omablo")

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

func _on_select_maximo_pressed() -> void:
	if CharacterManager:
		CharacterManager.select_character("maximo")
		_update_store_buttons()

func _on_select_omablo_pressed() -> void:
	if CharacterManager:
		CharacterManager.select_character("omablo")
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
