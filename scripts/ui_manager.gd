extends CanvasLayer

@onready var hud: Control = $HUD
@onready var score_label: Label = $HUD/ScoreLabel
@onready var coins_label: Label = $HUD/CoinsLabel
@onready var speed_label: Label = $HUD/SpeedLabel
@onready var notification_label: Label = $HUD/NotificationToastLabel

@onready var life_row: HBoxContainer = $HUD/PowerUpStatusBox/LifeRow
@onready var life_icon: TextureRect = $HUD/PowerUpStatusBox/LifeRow/LifeIcon
@onready var lives_status_label: Label = $HUD/PowerUpStatusBox/LifeRow/LifeLabel

@onready var shield_row: HBoxContainer = $HUD/PowerUpStatusBox/ShieldRow
@onready var shield_icon: TextureRect = $HUD/PowerUpStatusBox/ShieldRow/ShieldIcon
@onready var shield_status_label: Label = $HUD/PowerUpStatusBox/ShieldRow/ShieldLabel

@onready var fly_row: HBoxContainer = $HUD/PowerUpStatusBox/FlyRow
@onready var fly_icon: TextureRect = $HUD/PowerUpStatusBox/FlyRow/FlyIcon
@onready var fly_status_label: Label = $HUD/PowerUpStatusBox/FlyRow/FlyLabel

@onready var turbo_row: HBoxContainer = $HUD/PowerUpStatusBox/TurboRow
@onready var turbo_icon: TextureRect = $HUD/PowerUpStatusBox/TurboRow/TurboIcon
@onready var turbo_status_label: Label = $HUD/PowerUpStatusBox/TurboRow/TurboLabel

@onready var slot1_card: PanelContainer = $HUD/BoostHudHBox/Slot1Card
@onready var slot1_icon: TextureRect = $HUD/BoostHudHBox/Slot1Card/VBox/IconRect
@onready var slot1_qty: Label = $HUD/BoostHudHBox/Slot1Card/VBox/QtyLabel

@onready var slot2_card: PanelContainer = $HUD/BoostHudHBox/Slot2Card
@onready var slot2_icon: TextureRect = $HUD/BoostHudHBox/Slot2Card/VBox/IconRect
@onready var slot2_qty: Label = $HUD/BoostHudHBox/Slot2Card/VBox/QtyLabel

@onready var slot3_card: PanelContainer = $HUD/BoostHudHBox/Slot3Card
@onready var slot3_icon: TextureRect = $HUD/BoostHudHBox/Slot3Card/VBox/IconRect
@onready var slot3_qty: Label = $HUD/BoostHudHBox/Slot3Card/VBox/QtyLabel

@onready var main_menu: Control = $MainMenu
@onready var best_score_label: Label = $MainMenu/StatsContainer/BestScoreLabel
@onready var total_coins_label: Label = $MainMenu/StatsContainer/TotalCoinsLabel
@onready var play_button: Button = $MainMenu/ButtonsContainer/PlayButton
@onready var store_button: Button = $MainMenu/ButtonsContainer/StoreButton
@onready var settings_button: Button = $MainMenu/ButtonsContainer/SettingsButton
@onready var exit_button: Button = $MainMenu/ButtonsContainer/ExitButton

@onready var store_panel: Panel = $StorePanel
@onready var store_coins_label: Label = $StorePanel/StoreCoinsLabel

@onready var scroll_container: ScrollContainer = $StorePanel/ScrollContainer
@onready var scroll_left_button: Button = $StorePanel/ScrollLeftButton
@onready var scroll_right_button: Button = $StorePanel/ScrollRightButton

@onready var tired_card: PanelContainer = $StorePanel/ScrollContainer/CardsHBox/TiredCard
@onready var leech_card: PanelContainer = $StorePanel/ScrollContainer/CardsHBox/LeechCard
@onready var maximo_card: PanelContainer = $StorePanel/ScrollContainer/CardsHBox/MaximoCard
@onready var omablo_card: PanelContainer = $StorePanel/ScrollContainer/CardsHBox/OmabloCard
@onready var demon_card: PanelContainer = $StorePanel/ScrollContainer/CardsHBox/DemonCard

@onready var action_tired_button: Button = $StorePanel/ScrollContainer/CardsHBox/TiredCard/VBox/ActionTiredButton
@onready var action_leech_button: Button = $StorePanel/ScrollContainer/CardsHBox/LeechCard/VBox/ActionLeechButton
@onready var action_maximo_button: Button = $StorePanel/ScrollContainer/CardsHBox/MaximoCard/VBox/ActionMaximoButton
@onready var action_omablo_button: Button = $StorePanel/ScrollContainer/CardsHBox/OmabloCard/VBox/ActionOmabloButton
@onready var action_demon_button: Button = $StorePanel/ScrollContainer/CardsHBox/DemonCard/VBox/ActionDemonButton

@onready var shield_boost_card: PanelContainer = $StorePanel/BoostCardsHBox/ShieldBoostCard
@onready var shield_qty_label: Label = $StorePanel/BoostCardsHBox/ShieldBoostCard/VBox/QtyLabel
@onready var buy_shield_boost_button: Button = $StorePanel/BoostCardsHBox/ShieldBoostCard/VBox/ButtonsHBox/BuyShieldBoostButton
@onready var equip_shield_slot1_button: Button = $StorePanel/BoostCardsHBox/ShieldBoostCard/VBox/ButtonsHBox/EquipShieldSlot1Button

@onready var life_boost_card: PanelContainer = $StorePanel/BoostCardsHBox/LifeBoostCard
@onready var life_qty_label: Label = $StorePanel/BoostCardsHBox/LifeBoostCard/VBox/QtyLabel
@onready var buy_life_boost_button: Button = $StorePanel/BoostCardsHBox/LifeBoostCard/VBox/ButtonsHBox/BuyLifeBoostButton
@onready var equip_life_slot1_button: Button = $StorePanel/BoostCardsHBox/LifeBoostCard/VBox/ButtonsHBox/EquipLifeSlot1Button

@onready var slow_boost_card: PanelContainer = $StorePanel/BoostCardsHBox/SlowBoostCard
@onready var slow_qty_label: Label = $StorePanel/BoostCardsHBox/SlowBoostCard/VBox/QtyLabel
@onready var buy_slow_boost_button: Button = $StorePanel/BoostCardsHBox/SlowBoostCard/VBox/ButtonsHBox/BuySlowBoostButton
@onready var equip_slow_slot1_button: Button = $StorePanel/BoostCardsHBox/SlowBoostCard/VBox/ButtonsHBox/EquipSlowSlot1Button

@onready var fly_boost_card: PanelContainer = $StorePanel/BoostCardsHBox/FlyBoostCard
@onready var fly_qty_label: Label = $StorePanel/BoostCardsHBox/FlyBoostCard/VBox/QtyLabel
@onready var buy_fly_boost_button: Button = $StorePanel/BoostCardsHBox/FlyBoostCard/VBox/ButtonsHBox/BuyFlyBoostButton
@onready var equip_fly_slot1_button: Button = $StorePanel/BoostCardsHBox/FlyBoostCard/VBox/ButtonsHBox/EquipFlySlot1Button

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
	_setup_card_hover_effects()
	_setup_scroll_buttons()
	
	play_button.pressed.connect(_on_play_button_pressed)
	store_button.pressed.connect(_on_store_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	
	action_tired_button.pressed.connect(_on_action_tired_pressed)
	action_leech_button.pressed.connect(_on_action_leech_pressed)
	action_maximo_button.pressed.connect(_on_action_maximo_pressed)
	action_omablo_button.pressed.connect(_on_action_omablo_pressed)
	action_demon_button.pressed.connect(_on_action_demon_pressed)
	
	buy_shield_boost_button.pressed.connect(_on_buy_shield_boost_pressed)
	equip_shield_slot1_button.pressed.connect(_on_equip_shield_slot1_pressed)
	
	buy_life_boost_button.pressed.connect(_on_buy_life_boost_pressed)
	equip_life_slot1_button.pressed.connect(_on_equip_life_slot1_pressed)
	
	buy_slow_boost_button.pressed.connect(_on_buy_slow_boost_pressed)
	equip_slow_slot1_button.pressed.connect(_on_equip_slow_slot1_pressed)
	
	buy_fly_boost_button.pressed.connect(_on_buy_fly_boost_pressed)
	equip_fly_slot1_button.pressed.connect(_on_equip_fly_slot1_pressed)
	
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
	
	if CharacterManager:
		CharacterManager.unlocked_characters_changed.connect(_update_all_ui)
		CharacterManager.boost_inventory_changed.connect(_update_all_ui)
		CharacterManager.character_changed.connect(_on_character_changed_ui)

func _on_character_changed_ui(_char: CharacterData) -> void:
	_update_all_ui()

func _update_all_ui() -> void:
	_update_store_buttons()
	_update_hud_boost_slots()

func _update_hud_boost_slots() -> void:
	if not CharacterManager: return
	var curr_char = CharacterManager.get_current_character()
	var unlocked_slots = curr_char.boost_slots if curr_char else 0
	var pack_name = GameManager.selected_icon_pack if GameManager else "default"
	
	var slot_cards = [slot1_card, slot2_card, slot3_card]
	var slot_icons = [slot1_icon, slot2_icon, slot3_icon]
	var slot_qtys = [slot1_qty, slot2_qty, slot3_qty]
	
	for i in range(3):
		var card = slot_cards[i]
		var icon = slot_icons[i]
		var qty_lbl = slot_qtys[i]
		if not card or not icon or not qty_lbl: continue
		
		if i < unlocked_slots:
			card.modulate = Color.WHITE
			var boost_id = CharacterManager.equipped_boost_slots[i]
			if boost_id != "":
				var qty = CharacterManager.get_boost_qty(boost_id)
				qty_lbl.text = "x%d" % qty
				var icon_file = ""
				match boost_id:
					"shield_boost": icon_file = "shield.png"
					"life_boost": icon_file = "life.png"
					"slow_boost": icon_file = "slow.png"
					"fly_boost": icon_file = "fly.png"
				var tex = load("res://assets/powerups/%s/%s" % [pack_name, icon_file]) as Texture2D
				icon.texture = tex
				icon.visible = true
			else:
				icon.texture = null
				icon.visible = false
				qty_lbl.text = "EMPTY"
		else:
			card.modulate = Color(0.35, 0.35, 0.35, 0.5)
			icon.texture = null
			icon.visible = false
			qty_lbl.text = "LOCKED"

func _setup_scroll_buttons() -> void:
	if scroll_left_button:
		scroll_left_button.pressed.connect(_on_scroll_left_pressed)
	if scroll_right_button:
		scroll_right_button.pressed.connect(_on_scroll_right_pressed)
	if scroll_container:
		scroll_container.get_h_scroll_bar().value_changed.connect(_on_scroll_changed)
	_update_scroll_buttons_visibility()

func _on_scroll_left_pressed() -> void:
	if scroll_container:
		var target = max(0, scroll_container.scroll_horizontal - 220)
		var tween = create_tween()
		tween.tween_property(scroll_container, "scroll_horizontal", target, 0.2).set_trans(Tween.TRANS_QUAD)
		tween.finished.connect(_update_scroll_buttons_visibility)

func _on_scroll_right_pressed() -> void:
	if scroll_container:
		var bar = scroll_container.get_h_scroll_bar()
		var max_val = int(bar.max_value - bar.page)
		var target = min(max_val, scroll_container.scroll_horizontal + 220)
		var tween = create_tween()
		tween.tween_property(scroll_container, "scroll_horizontal", target, 0.2).set_trans(Tween.TRANS_QUAD)
		tween.finished.connect(_update_scroll_buttons_visibility)

func _on_scroll_changed(_val: float) -> void:
	_update_scroll_buttons_visibility()

func _update_scroll_buttons_visibility() -> void:
	if not scroll_container: return
	var bar = scroll_container.get_h_scroll_bar()
	var max_val = int(bar.max_value - bar.page)
	var curr = scroll_container.scroll_horizontal
	
	if scroll_left_button:
		scroll_left_button.visible = (curr > 5)
	if scroll_right_button:
		scroll_right_button.visible = (curr < max_val - 5)

func _setup_card_hover_effects() -> void:
	var cards = [tired_card, leech_card, maximo_card, omablo_card, demon_card, shield_boost_card, life_boost_card, slow_boost_card, fly_boost_card]
	for card in cards:
		if card:
			card.mouse_entered.connect(_on_card_mouse_entered.bind(card))
			card.mouse_exited.connect(_on_card_mouse_exited.bind(card))

func _on_card_mouse_entered(card: PanelContainer) -> void:
	var tween = create_tween()
	tween.tween_property(card, "scale", Vector2(1.04, 1.04), 0.12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_card_mouse_exited(card: PanelContainer) -> void:
	var tween = create_tween()
	tween.tween_property(card, "scale", Vector2(1.0, 1.0), 0.12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _setup_settings_options() -> void:
	# Icon Packs Option
	pack_option_button.clear()
	pack_option_button.add_item("DEFAULT", 0)
	pack_option_button.add_item("ARGENTO", 1)
	
	var current_pack = GameManager.selected_icon_pack if GameManager else "default"
	if current_pack == "argento":
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
	_update_hud_boost_slots()
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
		
	var pack_name = GameManager.selected_icon_pack if GameManager else "default"
		
	# 1. VIDA EXTRA (LIFE)
	if life_row:
		var lives = int(player.get("extra_lives"))
		life_row.visible = (lives > 0)
		if lives > 0:
			if lives_status_label: lives_status_label.text = "x%d" % lives
			if life_icon:
				var tex = load("res://assets/powerups/%s/life.png" % pack_name) as Texture2D
				if tex: life_icon.texture = tex

	# 2. ESCUDO (SHIELD)
	if shield_row:
		var has_shield = player.get("has_shield") == true
		shield_row.visible = has_shield
		if has_shield:
			if shield_status_label: shield_status_label.text = "%.1fs" % float(player.get("shield_timer"))
			if shield_icon:
				var tex = load("res://assets/powerups/%s/shield.png" % pack_name) as Texture2D
				if tex: shield_icon.texture = tex
		
	# 3. VUELO (FLY)
	if fly_row:
		var is_flying = player.get("is_flying") == true
		fly_row.visible = is_flying
		if is_flying:
			if fly_status_label: fly_status_label.text = "%.1fs" % float(player.get("fly_timer"))
			if fly_icon:
				var tex = load("res://assets/powerups/%s/fly.png" % pack_name) as Texture2D
				if tex: fly_icon.texture = tex
			
	# 4. TURBO DEBUFF (TURBO)
	if turbo_row:
		var is_turbo = player.get("is_turbo") == true
		turbo_row.visible = is_turbo
		if is_turbo:
			if turbo_status_label: turbo_status_label.text = "%.1fs" % float(player.get("turbo_timer"))
			if turbo_icon:
				var tex = load("res://assets/powerups/%s/turbo.png" % pack_name) as Texture2D
				if tex: turbo_icon.texture = tex

func _update_store_buttons() -> void:
	if store_coins_label:
		store_coins_label.text = "COINS: %d" % GameManager.total_coins
		
	if not CharacterManager:
		return
		
	var current_id = CharacterManager.current_character_id
	var char_buttons = {
		"tired": action_tired_button,
		"leech": action_leech_button,
		"maximo": action_maximo_button,
		"omablo": action_omablo_button,
		"demon": action_demon_button
	}
	
	for char_id in char_buttons.keys():
		var btn = char_buttons[char_id] as Button
		if not btn: continue
		
		if CharacterManager.is_unlocked(char_id):
			if current_id == char_id:
				btn.text = "EQUIPPED"
				btn.disabled = true
			else:
				btn.text = "EQUIP"
				btn.disabled = false
		else:
			var price = CharacterManager.characters[char_id].price
			btn.text = "BUY (%d COIN)" % price
			btn.disabled = (GameManager.total_coins < price)
			
	# Seccion de Boosts
	var shield_qty = CharacterManager.get_boost_qty("shield_boost")
	var life_qty = CharacterManager.get_boost_qty("life_boost")
	var slow_qty = CharacterManager.get_boost_qty("slow_boost")
	var fly_qty = CharacterManager.get_boost_qty("fly_boost")
	
	if shield_qty_label: shield_qty_label.text = "Owned: %d" % shield_qty
	if life_qty_label: life_qty_label.text = "Owned: %d" % life_qty
	if slow_qty_label: slow_qty_label.text = "Owned: %d" % slow_qty
	if fly_qty_label: fly_qty_label.text = "Owned: %d" % fly_qty
	
	if buy_shield_boost_button: buy_shield_boost_button.disabled = (GameManager.total_coins < 1)
	if buy_life_boost_button: buy_life_boost_button.disabled = (GameManager.total_coins < 1)
	if buy_slow_boost_button: buy_slow_boost_button.disabled = (GameManager.total_coins < 1)
	if buy_fly_boost_button: buy_fly_boost_button.disabled = (GameManager.total_coins < 1)
		
	var curr_char = CharacterManager.get_current_character()
	var has_slots = curr_char and curr_char.boost_slots > 0
	var slot_0_boost = CharacterManager.equipped_boost_slots[0]
	
	_update_boost_equip_btn(equip_shield_slot1_button, "shield_boost", slot_0_boost, shield_qty, has_slots)
	_update_boost_equip_btn(equip_life_slot1_button, "life_boost", slot_0_boost, life_qty, has_slots)
	_update_boost_equip_btn(equip_slow_slot1_button, "slow_boost", slot_0_boost, slow_qty, has_slots)
	_update_boost_equip_btn(equip_fly_slot1_button, "fly_boost", slot_0_boost, fly_qty, has_slots)

	_update_scroll_buttons_visibility()

func _update_boost_equip_btn(btn: Button, boost_id: String, active_boost: String, qty: int, has_slots: bool) -> void:
	if not btn: return
	btn.disabled = not has_slots or (active_boost != boost_id and qty < 1)
	if active_boost == boost_id:
		btn.text = "EQUIPPED"
	else:
		btn.text = "EQUIP" if has_slots else "NO SLOTS"

func _update_menu_stats() -> void:
	if best_score_label:
		best_score_label.text = "BEST SCORE: %d" % int(GameManager.high_score)
	if total_coins_label:
		total_coins_label.text = "TOTAL COINS: %d" % GameManager.total_coins

func _show_main_menu() -> void:
	_update_menu_stats()
	_update_all_ui()
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
	_update_all_ui()
	store_panel.visible = true

func _on_settings_button_pressed() -> void:
	_setup_settings_options()
	settings_panel.visible = true

func _on_pack_option_selected(index: int) -> void:
	var pack_name = "default" if index == 0 else "argento"
	if GameManager:
		GameManager.set_icon_pack(pack_name)
	_update_hud_boost_slots()

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

func _on_action_tired_pressed() -> void:
	_handle_character_action("tired")

func _on_action_leech_pressed() -> void:
	_handle_character_action("leech")

func _on_action_maximo_pressed() -> void:
	_handle_character_action("maximo")

func _on_action_omablo_pressed() -> void:
	_handle_character_action("omablo")

func _on_action_demon_pressed() -> void:
	_handle_character_action("demon")

func _handle_character_action(char_id: String) -> void:
	if not CharacterManager: return
	if CharacterManager.is_unlocked(char_id):
		CharacterManager.select_character(char_id)
	else:
		if CharacterManager.buy_character(char_id):
			CharacterManager.select_character(char_id)
	_update_all_ui()

func _on_buy_shield_boost_pressed() -> void:
	if CharacterManager:
		CharacterManager.buy_boost("shield_boost")
		_update_all_ui()

func _on_equip_shield_slot1_pressed() -> void:
	if CharacterManager:
		CharacterManager.equip_boost_to_slot(0, "shield_boost")
		_update_all_ui()

func _on_buy_life_boost_pressed() -> void:
	if CharacterManager:
		CharacterManager.buy_boost("life_boost")
		_update_all_ui()

func _on_equip_life_slot1_pressed() -> void:
	if CharacterManager:
		CharacterManager.equip_boost_to_slot(0, "life_boost")
		_update_all_ui()

func _on_buy_slow_boost_pressed() -> void:
	if CharacterManager:
		CharacterManager.buy_boost("slow_boost")
		_update_all_ui()

func _on_equip_slow_slot1_pressed() -> void:
	if CharacterManager:
		CharacterManager.equip_boost_to_slot(0, "slow_boost")
		_update_all_ui()

func _on_buy_fly_boost_pressed() -> void:
	if CharacterManager:
		CharacterManager.buy_boost("fly_boost")
		_update_all_ui()

func _on_equip_fly_slot1_pressed() -> void:
	if CharacterManager:
		CharacterManager.equip_boost_to_slot(0, "fly_boost")
		_update_all_ui()

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
	_update_hud_boost_slots()

func _on_game_restarted() -> void:
	main_menu.visible = false
	game_over_panel.visible = false
	store_panel.visible = false
	settings_panel.visible = false
	hud.visible = true
	if notification_label:
		notification_label.visible = false
	_update_hud_boost_slots()

func _on_menu_opened() -> void:
	_show_main_menu()

func _on_game_over() -> void:
	if summary_label:
		summary_label.text = "Final Score: %d  |  Coins: %d" % [int(GameManager.run_score), GameManager.run_coins]
	game_over_panel.visible = true
