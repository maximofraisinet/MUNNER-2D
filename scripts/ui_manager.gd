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
@onready var achievements_button: Button = $MainMenu/ButtonsContainer/AchievementsButton
@onready var casino_button: Button = $MainMenu/ButtonsContainer/CasinoButton
@onready var settings_button: Button = $MainMenu/ButtonsContainer/SettingsButton
@onready var exit_button: Button = $MainMenu/ButtonsContainer/ExitButton

@onready var modal_dimmer: ColorRect = $ModalDimmer
@onready var achievements_panel: Panel = $AchievementsPanel
@onready var achievements_vbox: VBoxContainer = $AchievementsPanel/ScrollContainer/AchievementsVBox
@onready var close_achievements_button: Button = $AchievementsPanel/CloseAchievementsButton
@onready var casino_panel: Panel = $CasinoPanel

@onready var store_panel: Panel = $StorePanel
@onready var store_coins_label: Label = $StorePanel/StoreCoinsLabel

@onready var characters_tab_button: Button = $StorePanel/StoreNavHBox/CharactersTabButton
@onready var perks_tab_button: Button = $StorePanel/StoreNavHBox/PerksTabButton

@onready var characters_view: Control = $StorePanel/CharactersView
@onready var perks_view: Control = $StorePanel/PerksView

@onready var scroll_container: ScrollContainer = $StorePanel/CharactersView/ScrollContainer
@onready var scroll_left_button: Button = $StorePanel/CharactersView/ScrollLeftButton
@onready var scroll_right_button: Button = $StorePanel/CharactersView/ScrollRightButton

@onready var tired_card: PanelContainer = $StorePanel/CharactersView/ScrollContainer/CardsHBox/TiredCard
@onready var leech_card: PanelContainer = $StorePanel/CharactersView/ScrollContainer/CardsHBox/LeechCard
@onready var maximo_card: PanelContainer = $StorePanel/CharactersView/ScrollContainer/CardsHBox/MaximoCard
@onready var omablo_card: PanelContainer = $StorePanel/CharactersView/ScrollContainer/CardsHBox/OmabloCard
@onready var ignacho_card: PanelContainer = $StorePanel/CharactersView/ScrollContainer/CardsHBox/IgnachoCard
@onready var demon_card: PanelContainer = $StorePanel/CharactersView/ScrollContainer/CardsHBox/DemonCard
@onready var messi_card: PanelContainer = $StorePanel/CharactersView/ScrollContainer/CardsHBox/MessiCard
@onready var dark_angel_card: PanelContainer = $StorePanel/CharactersView/ScrollContainer/CardsHBox/DarkAngelCard
@onready var demon_messi_card: PanelContainer = $StorePanel/CharactersView/ScrollContainer/CardsHBox/DemonMessiCard

@onready var action_tired_button: Button = $StorePanel/CharactersView/ScrollContainer/CardsHBox/TiredCard/VBox/ActionTiredButton
@onready var action_leech_button: Button = $StorePanel/CharactersView/ScrollContainer/CardsHBox/LeechCard/VBox/ActionLeechButton
@onready var action_maximo_button: Button = $StorePanel/CharactersView/ScrollContainer/CardsHBox/MaximoCard/VBox/ActionMaximoButton
@onready var action_omablo_button: Button = $StorePanel/CharactersView/ScrollContainer/CardsHBox/OmabloCard/VBox/ActionOmabloButton
@onready var action_ignacho_button: Button = $StorePanel/CharactersView/ScrollContainer/CardsHBox/IgnachoCard/VBox/ActionIgnachoButton
@onready var action_demon_button: Button = $StorePanel/CharactersView/ScrollContainer/CardsHBox/DemonCard/VBox/ActionDemonButton
@onready var action_messi_button: Button = $StorePanel/CharactersView/ScrollContainer/CardsHBox/MessiCard/VBox/ActionMessiButton
@onready var action_dark_angel_button: Button = $StorePanel/CharactersView/ScrollContainer/CardsHBox/DarkAngelCard/VBox/ActionDarkAngelButton
@onready var action_demon_messi_button: Button = $StorePanel/CharactersView/ScrollContainer/CardsHBox/DemonMessiCard/VBox/ActionDemonMessiButton

@onready var loadout_title_label: Label = $StorePanel/PerksView/LoadoutBarContainer/LoadoutTitleLabel
@onready var store_slot1_card: PanelContainer = $StorePanel/PerksView/LoadoutBarContainer/LoadoutSlotsHBox/Slot1Card
@onready var store_slot1_icon: TextureRect = $StorePanel/PerksView/LoadoutBarContainer/LoadoutSlotsHBox/Slot1Card/VBox/IconRect
@onready var store_slot1_qty: Label = $StorePanel/PerksView/LoadoutBarContainer/LoadoutSlotsHBox/Slot1Card/VBox/QtyLabel

@onready var store_slot2_card: PanelContainer = $StorePanel/PerksView/LoadoutBarContainer/LoadoutSlotsHBox/Slot2Card
@onready var store_slot2_icon: TextureRect = $StorePanel/PerksView/LoadoutBarContainer/LoadoutSlotsHBox/Slot2Card/VBox/IconRect
@onready var store_slot2_qty: Label = $StorePanel/PerksView/LoadoutBarContainer/LoadoutSlotsHBox/Slot2Card/VBox/QtyLabel

@onready var store_slot3_card: PanelContainer = $StorePanel/PerksView/LoadoutBarContainer/LoadoutSlotsHBox/Slot3Card
@onready var store_slot3_icon: TextureRect = $StorePanel/PerksView/LoadoutBarContainer/LoadoutSlotsHBox/Slot3Card/VBox/IconRect
@onready var store_slot3_qty: Label = $StorePanel/PerksView/LoadoutBarContainer/LoadoutSlotsHBox/Slot3Card/VBox/QtyLabel

@onready var perks_scroll_container: ScrollContainer = $StorePanel/PerksView/PerksScrollContainer
@onready var perks_scroll_left_button: Button = $StorePanel/PerksView/PerksScrollLeftButton
@onready var perks_scroll_right_button: Button = $StorePanel/PerksView/PerksScrollRightButton

@onready var shield_boost_card: PanelContainer = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/ShieldBoostCard
@onready var shield_preview_rect: TextureRect = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/ShieldBoostCard/VBox/PreviewRect
@onready var shield_qty_label: Label = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/ShieldBoostCard/VBox/QtyLabel
@onready var buy_shield_boost_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/ShieldBoostCard/VBox/ButtonsHBox/BuyShieldBoostButton
@onready var equip_shield_slot1_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/ShieldBoostCard/VBox/ButtonsHBox/EquipShieldSlot1Button

@onready var life_boost_card: PanelContainer = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/LifeBoostCard
@onready var life_preview_rect: TextureRect = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/LifeBoostCard/VBox/PreviewRect
@onready var life_qty_label: Label = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/LifeBoostCard/VBox/QtyLabel
@onready var buy_life_boost_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/LifeBoostCard/VBox/ButtonsHBox/BuyLifeBoostButton
@onready var equip_life_slot1_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/LifeBoostCard/VBox/ButtonsHBox/EquipLifeSlot1Button

@onready var slow_boost_card: PanelContainer = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/SlowBoostCard
@onready var slow_preview_rect: TextureRect = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/SlowBoostCard/VBox/PreviewRect
@onready var slow_qty_label: Label = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/SlowBoostCard/VBox/QtyLabel
@onready var buy_slow_boost_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/SlowBoostCard/VBox/ButtonsHBox/BuySlowBoostButton
@onready var equip_slow_slot1_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/SlowBoostCard/VBox/ButtonsHBox/EquipSlowSlot1Button

@onready var fly_boost_card: PanelContainer = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/FlyBoostCard
@onready var fly_preview_rect: TextureRect = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/FlyBoostCard/VBox/PreviewRect
@onready var fly_qty_label: Label = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/FlyBoostCard/VBox/QtyLabel
@onready var buy_fly_boost_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/FlyBoostCard/VBox/ButtonsHBox/BuyFlyBoostButton
@onready var equip_fly_slot1_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/FlyBoostCard/VBox/ButtonsHBox/EquipFlySlot1Button

@onready var coin_mult_boost_card: PanelContainer = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/CoinMultBoostCard
@onready var coin_mult_preview_rect: TextureRect = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/CoinMultBoostCard/VBox/PreviewRect
@onready var coin_mult_qty_label: Label = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/CoinMultBoostCard/VBox/QtyLabel
@onready var buy_coin_mult_boost_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/CoinMultBoostCard/VBox/ButtonsHBox/BuyCoinMultBoostButton
@onready var equip_coin_mult_slot1_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/CoinMultBoostCard/VBox/ButtonsHBox/EquipCoinMultSlot1Button

@onready var mega_slow_boost_card: PanelContainer = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/MegaSlowBoostCard
@onready var mega_slow_preview_rect: TextureRect = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/MegaSlowBoostCard/VBox/PreviewRect
@onready var mega_slow_qty_label: Label = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/MegaSlowBoostCard/VBox/QtyLabel
@onready var buy_mega_slow_boost_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/MegaSlowBoostCard/VBox/ButtonsHBox/BuyMegaSlowBoostButton
@onready var equip_mega_slow_slot1_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/MegaSlowBoostCard/VBox/ButtonsHBox/EquipMegaSlowSlot1Button

@onready var poison_boost_card: PanelContainer = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/PoisonBoostCard
@onready var poison_preview_rect: TextureRect = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/PoisonBoostCard/VBox/PreviewRect
@onready var buy_poison_button: Button = $StorePanel/PerksView/PerksScrollContainer/BoostCardsHBox/PoisonBoostCard/VBox/ButtonsHBox/BuyPoisonButton

@onready var close_store_button: Button = $StorePanel/CloseStoreButton

@onready var settings_panel: Panel = $SettingsPanel
@onready var rebind_jump_button: Button = $SettingsPanel/SettingsGrid/RebindJumpButton
@onready var music_playlist_option_button: OptionButton = $SettingsPanel/SettingsGrid/MusicPlaylistOptionButton
@onready var music_volume_slider: HSlider = $SettingsPanel/SettingsGrid/VolumeHBox/MusicVolumeHSlider
@onready var music_volume_label: Label = $SettingsPanel/SettingsGrid/VolumeHBox/MusicVolumeValueLabel
@onready var sfx_volume_slider: HSlider = $SettingsPanel/SettingsGrid/SfxVolumeHBox/SfxVolumeHSlider
@onready var sfx_volume_label: Label = $SettingsPanel/SettingsGrid/SfxVolumeHBox/SfxVolumeValueLabel
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
var is_rebind_listening: bool = false

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	
	_show_main_menu()
	_setup_settings_options()
	_setup_card_hover_effects()
	_setup_scroll_buttons()
	_setup_store_slot_click_handlers()
	
	play_button.pressed.connect(_on_play_button_pressed)
	store_button.pressed.connect(_on_store_button_pressed)
	achievements_button.pressed.connect(_on_achievements_button_pressed)
	close_achievements_button.pressed.connect(_on_close_achievements_button_pressed)
	casino_button.pressed.connect(_on_casino_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	
	rebind_jump_button.pressed.connect(_on_rebind_jump_pressed)
	
	if AchievementManager:
		AchievementManager.achievement_claimed.connect(_on_achievement_claimed)
	
	action_tired_button.pressed.connect(_on_action_tired_pressed)
	action_leech_button.pressed.connect(_on_action_leech_pressed)
	action_maximo_button.pressed.connect(_on_action_maximo_pressed)
	action_omablo_button.pressed.connect(_on_action_omablo_pressed)
	if action_ignacho_button:
		action_ignacho_button.pressed.connect(_on_action_ignacho_pressed)
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
	
	buy_coin_mult_boost_button.pressed.connect(_on_buy_coin_mult_boost_pressed)
	equip_coin_mult_slot1_button.pressed.connect(_on_equip_coin_mult_slot1_pressed)
	
	buy_mega_slow_boost_button.pressed.connect(_on_buy_mega_slow_boost_pressed)
	equip_mega_slow_slot1_button.pressed.connect(_on_equip_mega_slow_slot1_pressed)
	
	if buy_poison_button:
		buy_poison_button.pressed.connect(_on_buy_poison_pressed)
	
	characters_tab_button.pressed.connect(_on_characters_tab_pressed)
	perks_tab_button.pressed.connect(_on_perks_tab_pressed)
	
	close_store_button.pressed.connect(_on_close_store_button_pressed)
	
	if music_playlist_option_button:
		music_playlist_option_button.item_selected.connect(_on_music_playlist_selected)
	if music_volume_slider:
		music_volume_slider.value_changed.connect(_on_music_volume_changed)
	if sfx_volume_slider:
		sfx_volume_slider.value_changed.connect(_on_sfx_volume_changed)
	
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
		
	if casino_panel:
		if casino_panel.has_signal("casino_closed"):
			casino_panel.casino_closed.connect(_update_modal_dimmer)
		casino_panel.visibility_changed.connect(_update_modal_dimmer)
	if modal_dimmer:
		modal_dimmer.gui_input.connect(_on_modal_dimmer_gui_input)

func _on_modal_dimmer_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_close_any_open_modal()

func _on_icon_pack_changed_ui(_pack_name: String) -> void:
	_update_all_ui()

func _input(event: InputEvent) -> void:
	if is_rebind_listening:
		if event is InputEventKey and event.pressed and not event.echo:
			var key_code = event.physical_keycode if event.physical_keycode != 0 else event.keycode
			var key_name = OS.get_keycode_string(key_code).to_upper()
			if key_name == "":
				key_name = "KEY %d" % key_code
			GameManager.set_jump_binding("key", key_code, key_name)
			is_rebind_listening = false
			_update_rebind_button_text()
			get_viewport().set_input_as_handled()
			return
		elif event is InputEventMouseButton and event.pressed:
			var btn_idx = event.button_index
			var btn_name = "MOUSE %d" % btn_idx
			match btn_idx:
				MOUSE_BUTTON_LEFT: btn_name = "LEFT CLICK"
				MOUSE_BUTTON_RIGHT: btn_name = "RIGHT CLICK"
				MOUSE_BUTTON_MIDDLE: btn_name = "MIDDLE CLICK"
			GameManager.set_jump_binding("mouse", btn_idx, btn_name)
			is_rebind_listening = false
			_update_rebind_button_text()
			get_viewport().set_input_as_handled()
			return

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			if _close_any_open_modal():
				get_viewport().set_input_as_handled()
				return
		
		if GameManager.current_state == GameManager.State.START and not cheat_panel.visible:
			var key_str = OS.get_keycode_string(event.keycode).to_lower()
			if key_str.length() == 1 and key_str >= "a" and key_str <= "z":
				cheat_buffer += key_str
				if cheat_buffer.length() > 12:
					cheat_buffer = cheat_buffer.right(12)
				if cheat_buffer.ends_with("hesoyam"):
					cheat_buffer = ""
					_open_cheat_panel()

func _close_any_open_modal() -> bool:
	if cheat_panel and cheat_panel.visible:
		cheat_panel.visible = false
		_update_modal_dimmer()
		return true
	if casino_panel and casino_panel.visible:
		if casino_panel.has_method("_on_close_pressed"):
			casino_panel._on_close_pressed()
		else:
			casino_panel.visible = false
		_update_modal_dimmer()
		return true
	if achievements_panel and achievements_panel.visible:
		_on_close_achievements_button_pressed()
		return true
	if settings_panel and settings_panel.visible:
		_on_close_settings_button_pressed()
		return true
	if store_panel and store_panel.visible:
		_on_close_store_button_pressed()
		return true
	return false

func _open_cheat_panel() -> void:
	_animate_open_panel(cheat_panel)
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
	_update_modal_dimmer()

func _on_cheat_cancel_pressed() -> void:
	cheat_panel.visible = false
	_update_modal_dimmer()

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
					"mega_slow_boost": icon_file = "mega_slow.png"
					"fly_boost": icon_file = "fly.png"
					"coin_mult_boost": icon_file = "coin_mult.png"
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
	
	if perks_scroll_left_button:
		perks_scroll_left_button.pressed.connect(_on_perks_scroll_left_pressed)
	if perks_scroll_right_button:
		perks_scroll_right_button.pressed.connect(_on_perks_scroll_right_pressed)
	if perks_scroll_container:
		perks_scroll_container.get_h_scroll_bar().value_changed.connect(_on_perks_scroll_changed)
	_update_perks_scroll_buttons_visibility()

func _on_characters_tab_pressed() -> void:
	_switch_store_tab(true)

func _on_perks_tab_pressed() -> void:
	_switch_store_tab(false)

func _switch_store_tab(show_characters: bool) -> void:
	if characters_view: characters_view.visible = show_characters
	if perks_view: perks_view.visible = not show_characters
	
	if characters_tab_button:
		if show_characters:
			characters_tab_button.modulate = Color(1.0, 1.0, 1.0, 1.0)
		else:
			characters_tab_button.modulate = Color(0.6, 0.6, 0.6, 0.8)
	if perks_tab_button:
		if not show_characters:
			perks_tab_button.modulate = Color(1.0, 1.0, 1.0, 1.0)
		else:
			perks_tab_button.modulate = Color(0.6, 0.6, 0.6, 0.8)
			
	_update_scroll_buttons_visibility()
	_update_perks_scroll_buttons_visibility()

func _on_scroll_left_pressed() -> void:
	if scroll_container:
		var target = max(0, scroll_container.scroll_horizontal - 240)
		var tween = create_tween()
		tween.tween_property(scroll_container, "scroll_horizontal", target, 0.2).set_trans(Tween.TRANS_QUAD)
		tween.finished.connect(_update_scroll_buttons_visibility)

func _on_scroll_right_pressed() -> void:
	if scroll_container:
		var bar = scroll_container.get_h_scroll_bar()
		var max_val = int(bar.max_value - bar.page)
		var target = min(max_val, scroll_container.scroll_horizontal + 240)
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

func _on_perks_scroll_left_pressed() -> void:
	if perks_scroll_container:
		var target = max(0, perks_scroll_container.scroll_horizontal - 240)
		var tween = create_tween()
		tween.tween_property(perks_scroll_container, "scroll_horizontal", target, 0.2).set_trans(Tween.TRANS_QUAD)
		tween.finished.connect(_update_perks_scroll_buttons_visibility)

func _on_perks_scroll_right_pressed() -> void:
	if perks_scroll_container:
		var bar = perks_scroll_container.get_h_scroll_bar()
		var max_val = int(bar.max_value - bar.page)
		var target = min(max_val, perks_scroll_container.scroll_horizontal + 240)
		var tween = create_tween()
		tween.tween_property(perks_scroll_container, "scroll_horizontal", target, 0.2).set_trans(Tween.TRANS_QUAD)
		tween.finished.connect(_update_perks_scroll_buttons_visibility)

func _on_perks_scroll_changed(_val: float) -> void:
	_update_perks_scroll_buttons_visibility()

func _update_perks_scroll_buttons_visibility() -> void:
	if not perks_scroll_container: return
	var bar = perks_scroll_container.get_h_scroll_bar()
	var max_val = int(bar.max_value - bar.page)
	var curr = perks_scroll_container.scroll_horizontal
	
	if perks_scroll_left_button:
		perks_scroll_left_button.visible = (curr > 5)
	if perks_scroll_right_button:
		perks_scroll_right_button.visible = (curr < max_val - 5)

func _setup_card_hover_effects() -> void:
	var cards = [tired_card, leech_card, maximo_card, omablo_card, demon_card, messi_card, dark_angel_card, demon_messi_card, shield_boost_card, life_boost_card, slow_boost_card, mega_slow_boost_card, fly_boost_card, coin_mult_boost_card, poison_boost_card]
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
	if music_playlist_option_button and MusicManager:
		music_playlist_option_button.clear()
		music_playlist_option_button.add_item("ELECTRO (DEFAULT)", 0)
		music_playlist_option_button.add_item("HARD", 1)
		music_playlist_option_button.add_item("EPIC", 2)
		music_playlist_option_button.add_item("ARGENTA", 3)
		music_playlist_option_button.add_item("OFF", 4)
		
		match MusicManager.current_playlist:
			"hard": music_playlist_option_button.select(1)
			"epic": music_playlist_option_button.select(2)
			"argenta": music_playlist_option_button.select(3)
			"off": music_playlist_option_button.select(4)
			_: music_playlist_option_button.select(0)
			
	if music_volume_slider and MusicManager:
		music_volume_slider.value = MusicManager.music_volume * 100.0
		if music_volume_label:
			music_volume_label.text = "%d%%" % int(MusicManager.music_volume * 100.0)
			
	if sfx_volume_slider and SoundManager:
		sfx_volume_slider.value = SoundManager.sfx_volume * 100.0
		if sfx_volume_label:
			sfx_volume_label.text = "%d%%" % int(SoundManager.sfx_volume * 100.0)

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
	_update_rebind_button_text()

func _update_rebind_button_text() -> void:
	if rebind_jump_button and GameManager:
		rebind_jump_button.text = "%s (CLICK TO CHANGE)" % GameManager.jump_binding_name
		rebind_jump_button.modulate = Color.WHITE

func _on_rebind_jump_pressed() -> void:
	is_rebind_listening = true
	if rebind_jump_button:
		rebind_jump_button.text = "PRESS ANY KEY OR CLICK..."
		rebind_jump_button.modulate = Color(1.0, 0.9, 0.2, 1.0)

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
				shield_row.modulate = Color.WHITE
			else:
				if shield_status_label: shield_status_label.text = "%.1fs" % s_timer
				if s_timer <= 1.5:
					# Flashing warning pulse
					var pulse = 0.5 + 0.5 * sin(Time.get_ticks_msec() * 0.015)
					shield_row.modulate = Color(1.0, 0.4 + 0.6 * pulse, 0.4 + 0.6 * pulse, 1.0)
				else:
					shield_row.modulate = Color.WHITE
			if shield_icon:
				var tex = load("res://assets/powerups/%s/shield.png" % pack_name) as Texture2D
				if tex: shield_icon.texture = tex
		
	if fly_row:
		var is_flying = player.get("is_flying") == true
		fly_row.visible = is_flying
		if is_flying:
			var f_timer = float(player.get("fly_timer"))
			if fly_status_label: fly_status_label.text = "%.1fs" % f_timer
			if f_timer <= 2.0:
				# Flashing warning pulse before landing
				var pulse = 0.5 + 0.5 * sin(Time.get_ticks_msec() * 0.015)
				fly_row.modulate = Color(1.0, 0.7 + 0.3 * pulse, 0.2 + 0.8 * pulse, 1.0)
			else:
				fly_row.modulate = Color.WHITE
			if fly_icon:
				var tex = load("res://assets/powerups/%s/fly.png" % pack_name) as Texture2D
				if tex: fly_icon.texture = tex
			
	if turbo_row:
		var is_turbo = player.get("is_turbo") == true
		turbo_row.visible = is_turbo
		if is_turbo:
			var t_timer = float(player.get("turbo_timer"))
			if turbo_status_label: turbo_status_label.text = "%.1fs" % t_timer
			if t_timer <= 1.5:
				var pulse = 0.5 + 0.5 * sin(Time.get_ticks_msec() * 0.015)
				turbo_row.modulate = Color(1.0, 0.5 + 0.5 * pulse, 0.5 + 0.5 * pulse, 1.0)
			else:
				turbo_row.modulate = Color.WHITE
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
	if coin_mult_preview_rect:
		var tex = load("res://assets/powerups/%s/coin_mult.png" % pack_name) as Texture2D
		if tex: coin_mult_preview_rect.texture = tex
	if mega_slow_preview_rect:
		var tex = load("res://assets/powerups/%s/mega_slow.png" % pack_name) as Texture2D
		if tex: mega_slow_preview_rect.texture = tex
	if poison_preview_rect:
		var p_tex = load("res://assets/powerups/%s/poison.png" % pack_name) as Texture2D
		if p_tex: poison_preview_rect.texture = p_tex
		
	var current_id = CharacterManager.current_character_id
	var char_buttons = {
		"tired": action_tired_button,
		"leech": action_leech_button,
		"maximo": action_maximo_button,
		"omablo": action_omablo_button,
		"ignacho": action_ignacho_button,
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
	var coin_mult_qty = CharacterManager.get_boost_qty("coin_mult_boost")
	var mega_slow_qty = CharacterManager.get_boost_qty("mega_slow_boost")
	
	if shield_qty_label: shield_qty_label.text = "Owned: %d" % shield_qty
	if life_qty_label: life_qty_label.text = "Owned: %d" % life_qty
	if slow_qty_label: slow_qty_label.text = "Owned: %d" % slow_qty
	if fly_qty_label: fly_qty_label.text = "Owned: %d" % fly_qty
	if coin_mult_qty_label: coin_mult_qty_label.text = "Owned: %d" % coin_mult_qty
	if mega_slow_qty_label: mega_slow_qty_label.text = "Owned: %d" % mega_slow_qty
	
	if buy_shield_boost_button:
		var price = CharacterManager.get_boost_price("shield_boost")
		buy_shield_boost_button.text = "BUY (%s COINS)" % _format_number(price)
		buy_shield_boost_button.disabled = (GameManager.total_coins < price)
	if buy_life_boost_button:
		var price = CharacterManager.get_boost_price("life_boost")
		buy_life_boost_button.text = "BUY (%s COINS)" % _format_number(price)
		buy_life_boost_button.disabled = (GameManager.total_coins < price)
	if buy_slow_boost_button:
		var price = CharacterManager.get_boost_price("slow_boost")
		buy_slow_boost_button.text = "BUY (%s COINS)" % _format_number(price)
		buy_slow_boost_button.disabled = (GameManager.total_coins < price)
	if buy_fly_boost_button:
		var price = CharacterManager.get_boost_price("fly_boost")
		buy_fly_boost_button.text = "BUY (%s COINS)" % _format_number(price)
		buy_fly_boost_button.disabled = (GameManager.total_coins < price)
	if buy_coin_mult_boost_button:
		var price = CharacterManager.get_boost_price("coin_mult_boost")
		buy_coin_mult_boost_button.text = "BUY (%s COINS)" % _format_number(price)
		buy_coin_mult_boost_button.disabled = (GameManager.total_coins < price)
	if buy_mega_slow_boost_button:
		var price = CharacterManager.get_boost_price("mega_slow_boost")
		buy_mega_slow_boost_button.text = "BUY (%s COINS)" % _format_number(price)
		buy_mega_slow_boost_button.disabled = (GameManager.total_coins < price)
		
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
	_update_boost_equip_btn(equip_coin_mult_slot1_button, "coin_mult_boost", equipped_slots, coin_mult_qty, has_slots)
	_update_boost_equip_btn(equip_mega_slow_slot1_button, "mega_slow_boost", equipped_slots, mega_slow_qty, has_slots)

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
	if achievements_button and AchievementManager:
		var unclaimed = AchievementManager.get_unclaimed_count()
		if unclaimed > 0:
			achievements_button.text = "ACHIEVEMENTS (%d)" % unclaimed
		else:
			achievements_button.text = "ACHIEVEMENTS"

func _show_main_menu() -> void:
	main_menu.visible = true
	hud.visible = false
	game_over_panel.visible = false
	store_panel.visible = false
	if achievements_panel: achievements_panel.visible = false
	if casino_panel: casino_panel.visible = false
	settings_panel.visible = false
	if cheat_panel: cheat_panel.visible = false
	if modal_dimmer: modal_dimmer.visible = false

func _animate_open_panel(panel: Control) -> void:
	if not panel: return
	panel.visible = true
	if modal_dimmer: modal_dimmer.visible = true
	panel.modulate.a = 0.0
	panel.scale = Vector2(0.96, 0.96)
	panel.pivot_offset = panel.size * 0.5
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "modulate:a", 1.0, 0.15)
	tween.tween_property(panel, "scale", Vector2.ONE, 0.15)

func _update_modal_dimmer() -> void:
	if not modal_dimmer: return
	var any_open = (store_panel and store_panel.visible) or \
	               (achievements_panel and achievements_panel.visible) or \
	               (casino_panel and casino_panel.visible) or \
	               (settings_panel and settings_panel.visible) or \
	               (cheat_panel and cheat_panel.visible)
	modal_dimmer.visible = any_open

func _on_play_button_pressed() -> void:
	main_menu.visible = false
	hud.visible = true
	if casino_panel: casino_panel.visible = false
	if modal_dimmer: modal_dimmer.visible = false
	GameManager.start_game()

func _on_store_button_pressed() -> void:
	_switch_store_tab(true)
	_update_all_ui()
	if casino_panel: casino_panel.visible = false
	_animate_open_panel(store_panel)

func _on_achievements_button_pressed() -> void:
	_populate_achievements()
	if casino_panel: casino_panel.visible = false
	_animate_open_panel(achievements_panel)

func _on_casino_button_pressed() -> void:
	if SoundManager: SoundManager.play_click()
	if casino_panel:
		if modal_dimmer: modal_dimmer.visible = true
		casino_panel.open_casino()
		_animate_open_panel(casino_panel)

func _on_close_achievements_button_pressed() -> void:
	if achievements_panel: achievements_panel.visible = false
	_update_modal_dimmer()
	_update_menu_stats()

func _populate_achievements() -> void:
	if not achievements_vbox or not AchievementManager: return
	
	for child in achievements_vbox.get_children():
		child.queue_free()
		
	var curr_high_score = int(GameManager.high_score)
	
	for ach in AchievementManager.ACHIEVEMENTS:
		var id = ach["id"]
		var title = ach["title"]
		var desc = ach["desc"]
		var target = ach["target_score"]
		var reward = ach["reward"]
		var is_unlocked = curr_high_score >= target
		var is_claimed = AchievementManager.is_claimed(id)
		
		var card = PanelContainer.new()
		card.custom_minimum_size = Vector2(0, 56)
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.12, 0.12, 0.18, 0.95) if is_unlocked else Color(0.08, 0.08, 0.10, 0.8)
		style.set_border_width_all(2)
		style.border_color = Color(1.0, 0.84, 0.0, 0.8) if (is_unlocked and not is_claimed) else (Color(0.2, 0.8, 0.4, 0.8) if is_claimed else Color(0.25, 0.25, 0.35, 0.5))
		style.set_corner_radius_all(6)
		card.add_theme_stylebox_override("panel", style)
		
		var hbox = HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 14)
		hbox.alignment = BoxContainer.ALIGNMENT_CENTER
		
		var icon_lbl = Label.new()
		icon_lbl.text = " 🏆 " if is_unlocked else " 🔒 "
		icon_lbl.add_theme_font_size_override("font_size", 20)
		hbox.add_child(icon_lbl)
		
		var details_vbox = VBoxContainer.new()
		details_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		details_vbox.add_theme_constant_override("separation", 2)
		
		var title_lbl = Label.new()
		title_lbl.text = title
		title_lbl.add_theme_font_size_override("font_size", 14)
		title_lbl.add_theme_color_override("font_color", Color(1.0, 0.84, 0.0) if is_unlocked else Color(0.7, 0.7, 0.7))
		details_vbox.add_child(title_lbl)
		
		var desc_lbl = Label.new()
		desc_lbl.text = "%s (Best: %d / %d)" % [desc, min(curr_high_score, target), target]
		desc_lbl.add_theme_font_size_override("font_size", 11)
		desc_lbl.add_theme_color_override("font_color", Color(0.8, 0.85, 0.95))
		details_vbox.add_child(desc_lbl)
		
		var progress = ProgressBar.new()
		progress.custom_minimum_size = Vector2(0, 8)
		progress.max_value = target
		progress.value = min(curr_high_score, target)
		progress.show_percentage = false
		details_vbox.add_child(progress)
		
		hbox.add_child(details_vbox)
		
		var reward_lbl = Label.new()
		reward_lbl.text = "+%s COINS" % _format_number(reward)
		reward_lbl.add_theme_font_size_override("font_size", 13)
		reward_lbl.add_theme_color_override("font_color", Color(1.0, 0.84, 0.0))
		hbox.add_child(reward_lbl)
		
		if is_claimed:
			var claimed_lbl = Label.new()
			claimed_lbl.custom_minimum_size = Vector2(110, 32)
			claimed_lbl.text = "CLAIMED ✓"
			claimed_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			claimed_lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			claimed_lbl.add_theme_font_size_override("font_size", 12)
			claimed_lbl.add_theme_color_override("font_color", Color(0.3, 0.9, 0.4))
			hbox.add_child(claimed_lbl)
		elif is_unlocked:
			var claim_btn = Button.new()
			claim_btn.custom_minimum_size = Vector2(110, 32)
			claim_btn.text = "CLAIM!"
			claim_btn.add_theme_font_size_override("font_size", 13)
			claim_btn.pressed.connect(_on_claim_single_achievement.bind(id))
			hbox.add_child(claim_btn)
		else:
			var locked_lbl = Label.new()
			locked_lbl.custom_minimum_size = Vector2(110, 32)
			locked_lbl.text = "LOCKED 🔒"
			locked_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			locked_lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			locked_lbl.add_theme_font_size_override("font_size", 12)
			locked_lbl.add_theme_color_override("font_color", Color(0.5, 0.5, 0.6))
			hbox.add_child(locked_lbl)
			
		card.add_child(hbox)
		achievements_vbox.add_child(card)

func _on_claim_single_achievement(id: String) -> void:
	if AchievementManager:
		AchievementManager.claim_achievement(id)
		_populate_achievements()
		_update_all_ui()

func _on_achievement_claimed(_id: String, reward: int) -> void:
	_on_speed_notification_emitted("🏆 ACHIEVEMENT CLAIMED! +%s COINS! 💰" % _format_number(reward), Color(1.0, 0.84, 0.0))

func _on_settings_button_pressed() -> void:
	_setup_settings_options()
	if casino_panel: casino_panel.visible = false
	_animate_open_panel(settings_panel)

func _on_close_settings_button_pressed() -> void:
	settings_panel.visible = false
	_update_modal_dimmer()

func _on_music_playlist_selected(index: int) -> void:
	if not MusicManager: return
	match index:
		1: MusicManager.set_playlist("hard")
		2: MusicManager.set_playlist("epic")
		3: MusicManager.set_playlist("argenta")
		4: MusicManager.set_playlist("off")
		_: MusicManager.set_playlist("electro")

func _on_music_volume_changed(val: float) -> void:
	if not MusicManager: return
	MusicManager.set_volume(val / 100.0)
	if music_volume_label:
		music_volume_label.text = "%d%%" % int(val)

func _on_sfx_volume_changed(val: float) -> void:
	if not SoundManager: return
	SoundManager.set_sfx_volume(val / 100.0)
	if sfx_volume_label:
		sfx_volume_label.text = "%d%%" % int(val)

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

func _on_action_tired_pressed() -> void:
	_handle_character_action("tired")

func _on_action_leech_pressed() -> void:
	_handle_character_action("leech")

func _on_action_maximo_pressed() -> void:
	_handle_character_action("maximo")

func _on_action_omablo_pressed() -> void:
	_handle_character_action("omablo")

func _on_action_ignacho_pressed() -> void:
	_handle_character_action("ignacho")

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

func _on_buy_coin_mult_boost_pressed() -> void:
	if CharacterManager:
		CharacterManager.buy_boost("coin_mult_boost")
		_update_all_ui()

func _on_equip_coin_mult_slot1_pressed() -> void:
	_equip_to_first_available_slot("coin_mult_boost")
	_update_all_ui()

func _on_buy_mega_slow_boost_pressed() -> void:
	if CharacterManager:
		CharacterManager.buy_boost("mega_slow_boost")
		_update_all_ui()

func _on_equip_mega_slow_slot1_pressed() -> void:
	_equip_to_first_available_slot("mega_slow_boost")
	_update_all_ui()

func _on_buy_poison_pressed() -> void:
	var price = 75000
	if GameManager.total_coins >= price:
		_drink_poison_and_wipe_everything()

func _drink_poison_and_wipe_everything() -> void:
	GameManager.wipe_all_data()
	CharacterManager.wipe_all_data()
	if AchievementManager:
		AchievementManager.wipe_all_data()
	_update_all_ui()
	store_panel.visible = false
	_show_main_menu()
	_on_speed_notification_emitted("☠️ YOU DRANK POISON! ALL SCORE, COINS & CHARACTERS RESET TO 0! ☠️", Color(1.0, 0.1, 0.1))

func _on_close_store_button_pressed() -> void:
	store_panel.visible = false
	_update_modal_dimmer()

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
