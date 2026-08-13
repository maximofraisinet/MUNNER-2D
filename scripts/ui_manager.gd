extends CanvasLayer

@onready var hud: Control = $HUD
@onready var score_label: Label = $HUD/ScoreLabel
@onready var coins_label: Label = $HUD/CoinsLabel
@onready var speed_label: Label = $HUD/SpeedLabel
@onready var notification_label: Label = $HUD/NotificationToastLabel

@onready var lives_status_label: Label = $HUD/PowerUpStatusBox/LivesStatusLabel
@onready var shield_status_label: Label = $HUD/PowerUpStatusBox/ShieldStatusLabel
@onready var fly_status_label: Label = $HUD/PowerUpStatusBox/FlyStatusLabel
@onready var turbo_status_label: Label = $HUD/PowerUpStatusBox/TurboStatusLabel

@onready var main_menu: Control = $MainMenu
@onready var best_score_label: Label = $MainMenu/StatsContainer/BestScoreLabel
@onready var total_coins_label: Label = $MainMenu/StatsContainer/TotalCoinsLabel
@onready var play_button: Button = $MainMenu/ButtonsContainer/PlayButton
@onready var store_button: Button = $MainMenu/ButtonsContainer/StoreButton
@onready var settings_button: Button = $MainMenu/ButtonsContainer/SettingsButton
@onready var exit_button: Button = $MainMenu/ButtonsContainer/ExitButton

@onready var store_panel: Panel = $StorePanel
@onready var select_demon_button: Button = $StorePanel/CharactersHBox/DemonBox/SelectDemonButton
@onready var select_tired_button: Button = $StorePanel/CharactersHBox/TiredBox/SelectTiredButton
@onready var select_leech_button: Button = $StorePanel/CharactersHBox/LeechBox/SelectLeechButton
@onready var select_maximo_button: Button = $StorePanel/CharactersHBox/MaximoBox/SelectMaximoButton
@onready var select_omablo_button: Button = $StorePanel/CharactersHBox/OmabloBox/SelectOmabloButton
@onready var close_store_button: Button = $StorePanel/CloseStoreButton

@onready var settings_panel: Panel = $SettingsPanel
@onready var pack_option_button: OptionButton = $SettingsPanel/SettingsGrid/PackOptionButton
@onready var bg_option_button: OptionButton = $SettingsPanel/SettingsGrid/BgOptionButton
@onready var bg_preview_rect: TextureRect = $SettingsPanel/SettingsGrid/BgPreviewRect
@onready var close_settings_button: Button = $SettingsPanel/CloseSettingsButton

@onready var game_over_panel: Panel = $GameOverPanel
@onready var summary_label: Label = $GameOverPanel/SummaryLabel
@onready var restart_button: Button = $GameOverPanel/ButtonsContainer/RestartButton
@onready var menu_button: Button = $GameOverPanel/ButtonsContainer/MenuButton

@onready var player: Node2D = $"../Player"

var notification_timer: float = 0.0

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	
	_show_main_menu()
	_setup_settings_options()
	
	play_button.pressed.connect(_on_play_button_pressed)
	store_button.pressed.connect(_on_store_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	
	select_demon_button.pressed.connect(_on_select_demon_pressed)
	select_tired_button.pressed.connect(_on_select_tired_pressed)
	select_leech_button.pressed.connect(_on_select_leech_pressed)
	select_maximo_button.pressed.connect(_on_select_maximo_pressed)
	select_omablo_button.pressed.connect(_on_select_omablo_pressed)
	close_store_button.pressed.connect(_on_close_store_button_pressed)
	
	pack_option_button.item_selected.connect(_on_pack_option_selected)
	bg_option_button.item_selected.connect(_on_bg_option_selected)
	close_settings_button.pressed.connect(_on_close_settings_button_pressed)
	
	restart_button.pressed.connect(_on_restart_button_pressed)
	menu_button.pressed.connect(_on_menu_button_pressed)
	
	GameManager.game_started_triggered.connect(_on_game_started)
	GameManager.game_restarted_triggered.connect(_on_game_restarted)
	GameManager.menu_opened_triggered.connect(_on_menu_opened)
	GameManager.game_over_triggered.connect(_on_game_over)
	GameManager.speed_notification_emitted.connect(_on_speed_notification_emitted)

func _setup_settings_options() -> void:
	# Icon Packs Option
	pack_option_button.clear()
	pack_option_button.add_item("ARGENTO", 0)
	pack_option_button.add_item("DEFAULT", 1)
	
	var current_pack = GameManager.selected_icon_pack if GameManager else "argento"
	if current_pack == "default":
		pack_option_button.select(1)
	else:
		pack_option_button.select(0)
		
	# Background Option
	bg_option_button.clear()
	bg_option_button.add_item("BACKGROUND 1", 0)
	bg_option_button.add_item("BACKGROUND 2", 1)
	bg_option_button.add_item("BLACK", 2)
	bg_option_button.add_item("WHITE", 3)
	
	var current_bg = GameManager.selected_bg if GameManager else "bg-game1"
	match current_bg:
		"bg-game2": bg_option_button.select(1)
		"bg-black": bg_option_button.select(2)
		"bg-white": bg_option_button.select(3)
		_: bg_option_button.select(0)
		
	_update_bg_preview(current_bg)

func _update_bg_preview(bg_name: String) -> void:
	if bg_preview_rect:
		var preview_path = "res://assets/backgrounds/previews/%s_preview.png" % bg_name
		var tex = load(preview_path) as Texture2D
		if tex:
			bg_preview_rect.texture = tex

func _process(delta: float) -> void:
	if score_label:
		score_label.text = "SCORE: %d" % int(GameManager.run_score)
	if coins_label:
		coins_label.text = "COINS: %d" % GameManager.run_coins
	if speed_label:
		speed_label.text = "SPEED: %d px/s" % int(GameManager.effective_speed)

	_update_powerup_status()
	_update_notification_toast(delta)

func _on_speed_notification_emitted(message: String, text_color: Color) -> void:
	if notification_label:
		notification_label.text = message
		notification_label.set("theme_override_colors/font_color", text_color)
		notification_label.visible = true
		notification_timer = 2.0

func _update_notification_toast(delta: float) -> void:
	if notification_timer > 0.0:
		notification_timer -= delta
		if notification_timer <= 0.0:
			if notification_label:
				notification_label.visible = false

func _update_powerup_status() -> void:
	if not player:
		return
		
	if lives_status_label:
		var lives = int(player.get("extra_lives"))
		lives_status_label.visible = (lives > 0)
		if lives > 0:
			lives_status_label.text = "LIVES: %d" % lives

	if shield_status_label:
		var has_shield = player.get("has_shield") == true
		shield_status_label.visible = has_shield
		if has_shield:
			shield_status_label.text = "SHIELD: %.1fs" % float(player.get("shield_timer"))
		
	if fly_status_label:
		var is_flying = player.get("is_flying") == true
		fly_status_label.visible = is_flying
		if is_flying:
			fly_status_label.text = "FLYING: %.1fs" % float(player.get("fly_timer"))
			
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
	settings_panel.visible = false

func _on_play_button_pressed() -> void:
	main_menu.visible = false
	hud.visible = true
	GameManager.start_game()

func _on_store_button_pressed() -> void:
	_update_store_buttons()
	store_panel.visible = true

func _on_settings_button_pressed() -> void:
	_setup_settings_options()
	settings_panel.visible = true

func _on_pack_option_selected(index: int) -> void:
	var pack_name = "argento" if index == 0 else "default"
	if GameManager:
		GameManager.set_icon_pack(pack_name)

func _on_bg_option_selected(index: int) -> void:
	var bg_name = "bg-game1"
	match index:
		1: bg_name = "bg-game2"
		2: bg_name = "bg-black"
		3: bg_name = "bg-white"
	_update_bg_preview(bg_name)
	if GameManager:
		GameManager.set_background(bg_name)

func _on_close_settings_button_pressed() -> void:
	settings_panel.visible = false

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
	settings_panel.visible = false
	hud.visible = true
	if notification_label:
		notification_label.visible = false

func _on_game_restarted() -> void:
	main_menu.visible = false
	game_over_panel.visible = false
	store_panel.visible = false
	settings_panel.visible = false
	hud.visible = true
	if notification_label:
		notification_label.visible = false

func _on_menu_opened() -> void:
	_show_main_menu()

func _on_game_over() -> void:
	if summary_label:
		summary_label.text = "Final Score: %d  |  Coins: %d" % [int(GameManager.run_score), GameManager.run_coins]
	game_over_panel.visible = true
