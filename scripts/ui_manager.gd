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
@onready var menu_bg_rect: TextureRect = $MainMenu/Background
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
@onready var messi_card: PanelContainer = $StorePanel/ScrollContainer/CardsHBox/MessiCard
@onready var dark_angel_card: PanelContainer = $StorePanel/ScrollContainer/CardsHBox/DarkAngelCard
@onready var demon_messi_card: PanelContainer = $StorePanel/ScrollContainer/CardsHBox/DemonMessiCard

@onready var action_tired_button: Button = $StorePanel/ScrollContainer/CardsHBox/TiredCard/VBox/ActionTiredButton
@onready var action_leech_button: Button = $StorePanel/ScrollContainer/CardsHBox/LeechCard/VBox/ActionLeechButton
@onready var action_maximo_button: Button = $StorePanel/ScrollContainer/CardsHBox/MaximoCard/VBox/ActionMaximoButton
@onready var action_omablo_button: Button = $StorePanel/ScrollContainer/CardsHBox/OmabloCard/VBox/ActionOmabloButton
@onready var action_demon_button: Button = $StorePanel/ScrollContainer/CardsHBox/DemonCard/VBox/ActionDemonButton
@onready var action_messi_button: Button = $StorePanel/ScrollContainer/CardsHBox/MessiCard/VBox/ActionMessiButton
@onready var action_dark_angel_button: Button = $StorePanel/ScrollContainer/CardsHBox/DarkAngelCard/VBox/ActionDarkAngelButton
@onready var action_demon_messi_button: Button = $StorePanel/ScrollContainer/CardsHBox/DemonMessiCard/VBox/ActionDemonMessiButton

@onready var loadout_title_label: Label = $StorePanel/LoadoutBarContainer/LoadoutTitleLabel
@onready var store_slot1_card: PanelContainer = $StorePanel/LoadoutBarContainer/LoadoutSlotsHBox/Slot1Card
@onready var store_slot1_icon: TextureRect = $StorePanel/LoadoutBarContainer/LoadoutSlotsHBox/Slot1Card/VBox/IconRect
@onready var store_slot1_qty: Label = $StorePanel/LoadoutBarContainer/LoadoutSlotsHBox/Slot1Card/VBox/QtyLabel

@onready var store_slot2_card: PanelContainer = $StorePanel/LoadoutBarContainer/LoadoutSlotsHBox/Slot2Card
@onready var store_slot2_icon: TextureRect = $StorePanel/LoadoutBarContainer/LoadoutSlotsHBox/Slot2Card/VBox/IconRect
@onready var store_slot2_qty: Label = $StorePanel/LoadoutBarContainer/LoadoutSlotsHBox/Slot2Card/VBox/QtyLabel

@onready var store_slot3_card: PanelContainer = $StorePanel/LoadoutBarContainer/LoadoutSlotsHBox/Slot3Card
@onready var store_slot3_icon: TextureRect = $StorePanel/LoadoutBarContainer/LoadoutSlotsHBox/Slot3Card/VBox/IconRect
@onready var store_slot3_qty: Label = $StorePanel/LoadoutBarContainer/LoadoutSlotsHBox/Slot3Card/VBox/QtyLabel

@onready var shield_boost_card: PanelContainer = $StorePanel/BoostCardsHBox/ShieldBoostCard
@onready var shield_preview_rect: TextureRect = $StorePanel/BoostCardsHBox/ShieldBoostCard/VBox/PreviewRect
@onready var shield_qty_label: Label = $StorePanel/BoostCardsHBox/ShieldBoostCard/VBox/QtyLabel
@onready var buy_shield_boost_button: Button = $StorePanel/BoostCardsHBox/ShieldBoostCard/VBox/ButtonsHBox/BuyShieldBoostButton
@onready var equip_shield_slot1_button: Button = $StorePanel/BoostCardsHBox/ShieldBoostCard/VBox/ButtonsHBox/EquipShieldSlot1Button

@onready var life_boost_card: PanelContainer = $StorePanel/BoostCardsHBox/LifeBoostCard
@onready var life_preview_rect: TextureRect = $StorePanel/BoostCardsHBox/LifeBoostCard/VBox/PreviewRect
@onready var life_qty_label: Label = $StorePanel/BoostCardsHBox/LifeBoostCard/VBox/QtyLabel
@onready var buy_life_boost_button: Button = $StorePanel/BoostCardsHBox/LifeBoostCard/VBox/ButtonsHBox/BuyLifeBoostButton
@onready var equip_life_slot1_button: Button = $StorePanel/BoostCardsHBox/LifeBoostCard/VBox/ButtonsHBox/EquipLifeSlot1Button

@onready var slow_boost_card: PanelContainer = $StorePanel/BoostCardsHBox/SlowBoostCard
@onready var slow_preview_rect: TextureRect = $StorePanel/BoostCardsHBox/SlowBoostCard/VBox/PreviewRect
@onready var slow_qty_label: Label = $StorePanel/BoostCardsHBox/SlowBoostCard/VBox/QtyLabel
@onready var buy_slow_boost_button: Button = $StorePanel/BoostCardsHBox/SlowBoostCard/VBox/ButtonsHBox/BuySlowBoostButton
@onready var equip_slow_slot1_button: Button = $StorePanel/BoostCardsHBox/SlowBoostCard/VBox/ButtonsHBox/EquipSlowSlot1Button

@onready var fly_boost_card: PanelContainer = $StorePanel/BoostCardsHBox/FlyBoostCard
@onready var fly_preview_rect: TextureRect = $StorePanel/BoostCardsHBox/FlyBoostCard/VBox/PreviewRect
@onready var fly_qty_label: Label = $StorePanel/BoostCardsHBox/FlyBoostCard/VBox/QtyLabel
@onready var buy_fly_boost_button: Button = $StorePanel/BoostCardsHBox/FlyBoostCard/VBox/ButtonsHBox/BuyFlyBoostButton
@onready var equip_fly_slot1_button: Button = $StorePanel/BoostCardsHBox/FlyBoostCard/VBox/ButtonsHBox/EquipFlySlot1Button

@onready var poison_boost_card: PanelContainer = $StorePanel/BoostCardsHBox/PoisonBoostCard
@onready var poison_preview_rect: TextureRect = $StorePanel/BoostCardsHBox/PoisonBoostCard/VBox/PreviewRect
@onready var buy_poison_button: Button = $StorePanel/BoostCardsHBox/PoisonBoostCard/VBox/ButtonsHBox/BuyPoisonButton

@onready var close_store_button: Button = $StorePanel/CloseStoreButton

@onready var settings_panel: Panel = $SettingsPanel
@onready var ui_theme_option_button: OptionButton = $SettingsPanel/SettingsGrid/UiThemeOptionButton
@onready var pack_option_button: OptionButton = $SettingsPanel/SettingsGrid/PackOptionButton
@onready var bg_option_button: OptionButton = $SettingsPanel/SettingsGrid/BgOptionButton
@onready var bg_preview_rect: TextureRect = $SettingsPanel/SettingsGrid/BgPreviewRect
@onready var close_settings_button: Button = $SettingsPanel/CloseSettingsButton

@onready var cheat_panel: Panel = $CheatPanel
@onready var cheat_amount_input: LineEdit = $CheatPanel/AmountLineEdit
@onready var cheat_claim_button: Button = $CheatPanel/ButtonsHBox/ClaimButton
@onready var cheat_cancel_button: Button = $CheatPanel/ButtonsHBox/CancelButton

@onready var game_over_panel: Panel = $GameOverPanel
@onready var summary_label: Label = $GameOverPanel/SummaryLabel
@onready var restart_button: Button = $GameOverPanel/ButtonsContainer/RestartButton
@onready var menu_button: Button = $GameOverPanel/ButtonsContainer/MenuButton

@onready var player: Node2D = $"../Player"

var notification_timer: float = 0.0
var cheat_buffer: String = ""

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	
	_show_main_menu()
	_setup_settings_options()
	_setup_card_hover_effects()
	_setup_scroll_buttons()
	_setup_store_slot_click_handlers()
	
	play_button.pressed.connect(_on_play_button_pressed)
	store_button.pressed.connect(_on_store_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	
	action_tired_button.pressed.connect(_on_action_tired_pressed)
	action_leech_button.pressed.connect(_on_action_leech_pressed)
	action_maximo_button.pressed.connect(_on_action_maximo_pressed)
	action_omablo_button.pressed.connect(_on_action_omablo_pressed)
	action_demon_button.pressed.connect(_on_action_demon_pressed)
	action_messi_button.pressed.connect(_on_action_messi_pressed)
	action_dark_angel_button.pressed.connect(_on_action_dark_angel_pressed)
	action_demon_messi_button.pressed.connect(_on_action_demon_messi_pressed)
	
	buy_shield_boost_button.pressed.connect(_on_buy_shield_boost_pressed)
	equip_shield_slot1_button.pressed.connect(_on_equip_shield_slot1_pressed)
	
	buy_life_boost_button.pressed.connect(_on_buy_life_boost_pressed)
	equip_life_slot1_button.pressed.connect(_on_equip_life_slot1_pressed)
	
	buy_slow_boost_button.pressed.connect(_on_buy_slow_boost_pressed)
	equip_slow_slot1_button.pressed.connect(_on_equip_slow_slot1_pressed)
	
	buy_fly_boost_button.pressed.connect(_on_buy_fly_boost_pressed)
	equip_fly_slot1_button.pressed.connect(_on_equip_fly_slot1_pressed)
	
	if buy_poison_button:
		buy_poison_button.pressed.connect(_on_buy_poison_pressed)
	
	close_store_button.pressed.connect(_on_close_store_button_pressed)
	
	ui_theme_option_button.item_selected.connect(_on_ui_theme_selected)
	pack_option_button.item_selected.connect(_on_pack_option_selected)
	bg_option_button.item_selected.connect(_on_bg_option_selected)
	close_settings_button.pressed.connect(_on_close_settings_button_pressed)
	
	cheat_claim_button.pressed.connect(_on_cheat_claim_pressed)
	cheat_cancel_button.pressed.connect(_on_cheat_cancel_pressed)
	cheat_amount_input.text_submitted.connect(_on_cheat_amount_submitted)
	
	restart_button.pressed.connect(_on_restart_button_pressed)
	menu_button.pressed.connect(_on_menu_button_pressed)
	
	GameManager.game_started_triggered.connect(_on_game_started)
	GameManager.game_restarted_triggered.connect(_on_game_restarted)
	GameManager.menu_opened_triggered.connect(_on_menu_opened)
	GameManager.game_over_triggered.connect(_on_game_over)
	GameManager.speed_notification_emitted.connect(_on_speed_notification_emitted)
	if GameManager.has_signal("ui_theme_changed"):
		GameManager.ui_theme_changed.connect(_update_ui_theme_bg)
	if GameManager.has_signal("icon_pack_changed"):
		GameManager.icon_pack_changed.connect(_on_icon_pack_changed_ui)
	
	if CharacterManager:
		CharacterManager.unlocked_characters_changed.connect(_update_all_ui)
		CharacterManager.boost_inventory_changed.connect(_update_all_ui)
		CharacterManager.character_changed.connect(_on_character_changed_ui)

func _on_icon_pack_changed_ui(_pack_name: String) -> void:
	_update_all_ui()

func _unhandled_input(event: InputEvent) -> void:
	if GameManager.current_state == GameManager.State.START and not cheat_panel.visible:
		if event is InputEventKey and event.pressed and not event.echo:
			var key_str = OS.get_keycode_string(event.keycode).to_lower()
			if key_str.length() == 1 and key_str >= "a" and key_str <= "z":
				cheat_buffer += key_str
				if cheat_buffer.length() > 12:
					cheat_buffer = cheat_buffer.right(12)
				if cheat_buffer.ends_with("hesoyam"):
					cheat_buffer = ""
					_open_cheat_panel()

func _open_cheat_panel() -> void:
	cheat_panel.visible = true
	cheat_amount_input.text = ""
	cheat_amount_input.grab_focus()

func _on_cheat_claim_pressed() -> void:
	_apply_cheat_coins()

func _on_cheat_amount_submitted(_new_text: String) -> void:
	_apply_cheat_coins()

func _apply_cheat_coins() -> void:
	var amount = cheat_amount_input.text.to_int()
	if amount > 0:
		GameManager.total_coins += amount
		GameManager.save_data()
		_update_all_ui()
	cheat_panel.visible = false

func _on_cheat_cancel_pressed() -> void:
	cheat_panel.visible = false

func _setup_store_slot_click_handlers() -> void:
	var slots = [store_slot1_card, store_slot2_card, store_slot3_card]
	for i in range(3):
		var card = slots[i]
		if card:
			card.gui_input.connect(_on_store_slot_gui_input.bind(i))

func _on_store_slot_gui_input(event: InputEvent, slot_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if CharacterManager:
			var curr = CharacterManager.get_current_character()
			if curr and slot_idx < curr.boost_slots:
				CharacterManager.equipped_boost_slots[slot_idx] = ""
				CharacterManager.save_data()
				CharacterManager.boost_inventory_changed.emit()

func _on_character_changed_ui(_char: CharacterData) -> void:
	_update_all_ui()

func _update_all_ui() -> void:
	_update_menu_stats()
	_update_store_buttons()
	_update_store_loadout_bar()
	_update_hud_boost_slots()

func _update_store_loadout_bar() -> void:
	if not CharacterManager: return
	var curr_char = CharacterManager.get_current_character()
	if loadout_title_label and curr_char:
		loadout_title_label.text = "EQUIPPED LOADOUT (CURRENT: %s)" % curr_char.display_name
		
	var unlocked_slots = curr_char.boost_slots if curr_char else 0
	var pack_name = GameManager.selected_icon_pack if GameManager else "default"
	
	var cards = [store_slot1_card, store_slot2_card, store_slot3_card]
	var icons = [store_slot1_icon, store_slot2_icon, store_slot3_icon]
	var qtys = [store_slot1_qty, store_slot2_qty, store_slot3_qty]
	
	for i in range(3):
		var card = cards[i]
		var icon = icons[i]
		var qty_lbl = qtys[i]
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
	var cards = [tired_card, leech_card, maximo_card, omablo_card, demon_card, messi_card, dark_angel_card, demon_messi_card, shield_boost_card, life_boost_card, slow_boost_card, fly_boost_card, poison_boost_card]
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
	if ui_theme_option_button:
		ui_theme_option_button.clear()
		ui_theme_option_button.add_item("LIGHT", 0)
		ui_theme_option_button.add_item("DARK", 1)
		
		var current_theme = GameManager.selected_ui_theme if GameManager else "light"
		if current_theme == "dark":
			ui_theme_option_button.select(1)
		else:
			ui_theme_option_button.select(0)
		_update_ui_theme_bg(current_theme)

	pack_option_button.clear()
	pack_option_button.add_item("DEFAULT", 0)
	pack_option_button.add_item("ARGENTO", 1)
	
	var current_pack = GameManager.selected_icon_pack if GameManager else "default"
	if current_pack == "argento":
		pack_option_button.select(1)
	else:
		pack_option_button.select(0)
		
	bg_option_button.clear()
	bg_option_button.add_item("BACKGROUND 1", 0)
	bg_option_button.add_item("BACKGROUND 2", 1)
	bg_option_button.add_item("BACKGROUND 3", 2)
	bg_option_button.add_item("BLACK", 3)
	bg_option_button.add_item("WHITE", 4)
	
	var current_bg = GameManager.selected_bg if GameManager else "bg-game1"
	match current_bg:
		"bg-game2": bg_option_button.select(1)
		"bg-game3": bg_option_button.select(2)
		"bg-black": bg_option_button.select(3)
		"bg-white": bg_option_button.select(4)
		_: bg_option_button.select(0)
		
	_update_bg_preview(current_bg)

func _update_ui_theme_bg(theme_name: String) -> void:
	if menu_bg_rect:
		var tex_path = "res://assets/ui/bg-menu-%s.png" % theme_name
		var tex = load(tex_path) as Texture2D
		if tex:
			menu_bg_rect.texture = tex

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
		notification_timer = 3.0

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
		
	if life_row:
		var lives = int(player.get("extra_lives"))
		life_row.visible = (lives > 0)
		if lives > 0:
			if lives_status_label: lives_status_label.text = "x%d" % lives
			if life_icon:
				var tex = load("res://assets/powerups/%s/life.png" % pack_name) as Texture2D
				if tex: life_icon.texture = tex

	if shield_row:
		var has_shield = player.get("has_shield") == true
		shield_row.visible = has_shield
		if has_shield:
			var s_timer = float(player.get("shield_timer"))
			if s_timer > 999.0:
				if shield_status_label: shield_status_label.text = "PERMA"
			else:
				if shield_status_label: shield_status_label.text = "%.1fs" % s_timer
			if shield_icon:
				var tex = load("res://assets/powerups/%s/shield.png" % pack_name) as Texture2D
				if tex: shield_icon.texture = tex
		
	if fly_row:
		var is_flying = player.get("is_flying") == true
		fly_row.visible = is_flying
		if is_flying:
			if fly_status_label: fly_status_label.text = "%.1fs" % float(player.get("fly_timer"))
			if fly_icon:
				var tex = load("res://assets/powerups/%s/fly.png" % pack_name) as Texture2D
				if tex: fly_icon.texture = tex
			
	if turbo_row:
		var is_turbo = player.get("is_turbo") == true
		turbo_row.visible = is_turbo
		if is_turbo:
			if turbo_status_label: turbo_status_label.text = "%.1fs" % float(player.get("turbo_timer"))
			if turbo_icon:
				var tex = load("res://assets/powerups/%s/turbo.png" % pack_name) as Texture2D
				if tex: turbo_icon.texture = tex

func _format_number(n: int) -> String:
	var s = str(n)
	var result = ""
	var count = 0
	for i in range(s.length() - 1, -1, -1):
		if count > 0 and count % 3 == 0:
			result = "," + result
		result = s[i] + result
		count += 1
	return result

func _update_store_buttons() -> void:
	if store_coins_label:
		store_coins_label.text = "COINS: %s" % _format_number(GameManager.total_coins)
		
	if not CharacterManager:
		return
		
	var pack_name = GameManager.selected_icon_pack if GameManager else "default"
	
	# Actualizar dinámicamente las previsualizaciones de iconos en la tienda según el paquete seleccionado
	if shield_preview_rect:
		var tex = load("res://assets/powerups/%s/shield.png" % pack_name) as Texture2D
		if tex: shield_preview_rect.texture = tex
	if life_preview_rect:
		var tex = load("res://assets/powerups/%s/life.png" % pack_name) as Texture2D
		if tex: life_preview_rect.texture = tex
	if slow_preview_rect:
		var tex = load("res://assets/powerups/%s/slow.png" % pack_name) as Texture2D
		if tex: slow_preview_rect.texture = tex
	if fly_preview_rect:
		var tex = load("res://assets/powerups/%s/fly.png" % pack_name) as Texture2D
		if tex: fly_preview_rect.texture = tex
	if poison_preview_rect:
		var p_tex = load("res://assets/powerups/%s/poison.png" % pack_name) as Texture2D
		if p_tex: poison_preview_rect.texture = p_tex
		
	var current_id = CharacterManager.current_character_id
	var char_buttons = {
		"tired": action_tired_button,
		"leech": action_leech_button,
		"maximo": action_maximo_button,
		"omablo": action_omablo_button,
		"demon": action_demon_button,
		"messi": action_messi_button,
		"dark_angel": action_dark_angel_button,
		"demon_messi": action_demon_messi_button
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
			btn.text = "BUY (%s COINS)" % _format_number(price)
			btn.disabled = (GameManager.total_coins < price)
			
	var shield_qty = CharacterManager.get_boost_qty("shield_boost")
	var life_qty = CharacterManager.get_boost_qty("life_boost")
	var slow_qty = CharacterManager.get_boost_qty("slow_boost")
	var fly_qty = CharacterManager.get_boost_qty("fly_boost")
	
	if shield_qty_label: shield_qty_label.text = "Owned: %d" % shield_qty
	if life_qty_label: life_qty_label.text = "Owned: %d" % life_qty
	if slow_qty_label: slow_qty_label.text = "Owned: %d" % slow_qty
	if fly_qty_label: fly_qty_label.text = "Owned: %d" % fly_qty
	
	if buy_shield_boost_button:
		var price = CharacterManager.get_boost_price("shield_boost")
		buy_shield_boost_button.text = "BUY (%d COINS)" % price
		buy_shield_boost_button.disabled = (GameManager.total_coins < price)
	if buy_life_boost_button:
		var price = CharacterManager.get_boost_price("life_boost")
		buy_life_boost_button.text = "BUY (%d COINS)" % price
		buy_life_boost_button.disabled = (GameManager.total_coins < price)
	if buy_slow_boost_button:
		var price = CharacterManager.get_boost_price("slow_boost")
		buy_slow_boost_button.text = "BUY (%d COINS)" % price
		buy_slow_boost_button.disabled = (GameManager.total_coins < price)
	if buy_fly_boost_button:
		var price = CharacterManager.get_boost_price("fly_boost")
		buy_fly_boost_button.text = "BUY (%d COINS)" % price
		buy_fly_boost_button.disabled = (GameManager.total_coins < price)
		
	if buy_poison_button:
		var price = CharacterManager.get_boost_price("poison")
		buy_poison_button.text = "BUY (%s COINS)" % _format_number(price)
		buy_poison_button.disabled = (GameManager.total_coins < price)
		
	var curr_char = CharacterManager.get_current_character()
	var has_slots = curr_char and curr_char.boost_slots > 0
	var equipped_slots = CharacterManager.equipped_boost_slots
	
	_update_boost_equip_btn(equip_shield_slot1_button, "shield_boost", equipped_slots, shield_qty, has_slots)
	_update_boost_equip_btn(equip_life_slot1_button, "life_boost", equipped_slots, life_qty, has_slots)
	_update_boost_equip_btn(equip_slow_slot1_button, "slow_boost", equipped_slots, slow_qty, has_slots)
	_update_boost_equip_btn(equip_fly_slot1_button, "fly_boost", equipped_slots, fly_qty, has_slots)

	_update_scroll_buttons_visibility()

func _update_boost_equip_btn(btn: Button, boost_id: String, equipped_slots: Array, qty: int, has_slots: bool) -> void:
	if not btn: return
	if not has_slots:
		btn.text = "NO SLOTS"
		btn.disabled = true
	elif boost_id in equipped_slots:
		btn.text = "EQUIPPED"
		btn.disabled = false
	else:
		btn.text = "EQUIP"
		btn.disabled = (qty < 1)

func _update_menu_stats() -> void:
	if best_score_label:
		best_score_label.text = "BEST SCORE: %d" % int(GameManager.high_score)
	if total_coins_label:
		total_coins_label.text = "TOTAL COINS: %s" % _format_number(GameManager.total_coins)

func _show_main_menu() -> void:
	_update_menu_stats()
	_update_all_ui()
	main_menu.visible = true
	hud.visible = false
	game_over_panel.visible = false
	store_panel.visible = false
	settings_panel.visible = false
	if cheat_panel: cheat_panel.visible = false

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

func _on_ui_theme_selected(index: int) -> void:
	var theme_name = "light" if index == 0 else "dark"
	if GameManager:
		GameManager.set_ui_theme(theme_name)
	_update_ui_theme_bg(theme_name)

func _on_pack_option_selected(index: int) -> void:
	var pack_name = "default" if index == 0 else "argento"
	if GameManager:
		GameManager.set_icon_pack(pack_name)
	_update_all_ui()

func _on_bg_option_selected(index: int) -> void:
	var bg_name = "bg-game1"
	match index:
		1: bg_name = "bg-game2"
		2: bg_name = "bg-game3"
		3: bg_name = "bg-black"
		4: bg_name = "bg-white"
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

func _on_action_messi_pressed() -> void:
	_handle_character_action("messi")

func _on_action_dark_angel_pressed() -> void:
	_handle_character_action("dark_angel")

func _on_action_demon_messi_pressed() -> void:
	_handle_character_action("demon_messi")

func _handle_character_action(char_id: String) -> void:
	if not CharacterManager: return
	if CharacterManager.is_unlocked(char_id):
		CharacterManager.select_character(char_id)
	else:
		if CharacterManager.buy_character(char_id):
			CharacterManager.select_character(char_id)
	_update_all_ui()

func _equip_to_first_available_slot(boost_id: String) -> void:
	if not CharacterManager: return
	var curr = CharacterManager.get_current_character()
	if not curr or curr.boost_slots == 0: return
	
	if boost_id in CharacterManager.equipped_boost_slots:
		for i in range(curr.boost_slots):
			if CharacterManager.equipped_boost_slots[i] == boost_id:
				CharacterManager.equip_boost_to_slot(i, boost_id)
				return
				
	for i in range(curr.boost_slots):
		if CharacterManager.equipped_boost_slots[i] == "":
			CharacterManager.equip_boost_to_slot(i, boost_id)
			return
			
	CharacterManager.equip_boost_to_slot(0, boost_id)

func _on_buy_shield_boost_pressed() -> void:
	if CharacterManager:
		CharacterManager.buy_boost("shield_boost")
		_update_all_ui()

func _on_equip_shield_slot1_pressed() -> void:
	_equip_to_first_available_slot("shield_boost")
	_update_all_ui()

func _on_buy_life_boost_pressed() -> void:
	if CharacterManager:
		CharacterManager.buy_boost("life_boost")
		_update_all_ui()

func _on_equip_life_slot1_pressed() -> void:
	_equip_to_first_available_slot("life_boost")
	_update_all_ui()

func _on_buy_slow_boost_pressed() -> void:
	if CharacterManager:
		CharacterManager.buy_boost("slow_boost")
		_update_all_ui()

func _on_equip_slow_slot1_pressed() -> void:
	_equip_to_first_available_slot("slow_boost")
	_update_all_ui()

func _on_buy_fly_boost_pressed() -> void:
	if CharacterManager:
		CharacterManager.buy_boost("fly_boost")
		_update_all_ui()

func _on_equip_fly_slot1_pressed() -> void:
	_equip_to_first_available_slot("fly_boost")
	_update_all_ui()

func _on_buy_poison_pressed() -> void:
	var price = 75000
	if GameManager.total_coins >= price:
		_drink_poison_and_wipe_everything()

func _drink_poison_and_wipe_everything() -> void:
	GameManager.wipe_all_data()
	CharacterManager.wipe_all_data()
	_update_all_ui()
	store_panel.visible = false
	_show_main_menu()
	_on_speed_notification_emitted("☠️ YOU DRANK POISON! ALL SCORE, COINS & CHARACTERS RESET TO 0! ☠️", Color(1.0, 0.1, 0.1))

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
	if cheat_panel: cheat_panel.visible = false
	hud.visible = true
	if notification_label:
		notification_label.visible = false
	_update_all_ui()

func _on_game_restarted() -> void:
	main_menu.visible = false
	game_over_panel.visible = false
	store_panel.visible = false
	settings_panel.visible = false
	if cheat_panel: cheat_panel.visible = false
	hud.visible = true
	if notification_label:
		notification_label.visible = false
	_update_all_ui()

func _on_menu_opened() -> void:
	_show_main_menu()

func _on_game_over() -> void:
	if summary_label:
		summary_label.text = "Final Score: %d  |  Coins: %d" % [int(GameManager.run_score), GameManager.run_coins]
	game_over_panel.visible = true
