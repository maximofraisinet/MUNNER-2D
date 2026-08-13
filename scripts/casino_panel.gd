extends Panel
class_name CasinoPanel

# ==============================================================================
# CASINO & GAMBLE SYSTEM (Godot 4 Endless Runner)
# Minigames: 1. Lucky Slots, 2. Coin Flip, 3. Mines
# ==============================================================================

# --- UI NODES ---
@onready var casino_coins_label: Label = $TopBar/CasinoCoinsLabel
@onready var close_button: Button = $TopBar/CloseCasinoButton

# Tab Navigation
@onready var slots_tab_button: Button = $NavHBox/SlotsTabButton
@onready var coinflip_tab_button: Button = $NavHBox/CoinFlipTabButton
@onready var mines_tab_button: Button = $NavHBox/MinesTabButton

@onready var slots_view: Control = $Views/SlotsView
@onready var coinflip_view: Control = $Views/CoinFlipView
@onready var mines_view: Control = $Views/MinesView

# Shared Bet Selector
@onready var bet_amount_label: Label = $BetBar/BetAmountLabel
@onready var chip_100_btn: Button = $BetBar/ChipsHBox/Chip100Button
@onready var chip_500_btn: Button = $BetBar/ChipsHBox/Chip500Button
@onready var chip_1k_btn: Button = $BetBar/ChipsHBox/Chip1kButton
@onready var chip_5k_btn: Button = $BetBar/ChipsHBox/Chip5kButton
@onready var chip_half_btn: Button = $BetBar/ChipsHBox/ChipHalfButton
@onready var chip_2x_btn: Button = $BetBar/ChipsHBox/Chip2xButton
@onready var chip_max_btn: Button = $BetBar/ChipsHBox/ChipMaxButton
@onready var chip_clear_btn: Button = $BetBar/ChipsHBox/ChipClearButton

# 1. SLOTS NODES
@onready var reel1_label: Label = $Views/SlotsView/ReelsContainer/Reel1/Label
@onready var reel2_label: Label = $Views/SlotsView/ReelsContainer/Reel2/Label
@onready var reel3_label: Label = $Views/SlotsView/ReelsContainer/Reel3/Label
@onready var spin_button: Button = $Views/SlotsView/SpinButton
@onready var slots_status_label: Label = $Views/SlotsView/StatusLabel

# 2. COIN FLIP NODES
@onready var heads_button: Button = $Views/CoinFlipView/ChoiceHBox/HeadsButton
@onready var tails_button: Button = $Views/CoinFlipView/ChoiceHBox/TailsButton
@onready var coin_display: PanelContainer = $Views/CoinFlipView/CoinDisplay
@onready var coin_symbol_label: Label = $Views/CoinFlipView/CoinDisplay/SymbolLabel
@onready var flip_button: Button = $Views/CoinFlipView/FlipButton
@onready var coinflip_status_label: Label = $Views/CoinFlipView/StatusLabel

# 3. MINES NODES
@onready var mines_grid: GridContainer = $Views/MinesView/MinesLayoutHBox/GridContainer
@onready var start_mines_button: Button = $Views/MinesView/MinesLayoutHBox/ControlVBox/StartMinesButton
@onready var cashout_button: Button = $Views/MinesView/MinesLayoutHBox/ControlVBox/CashoutButton
@onready var current_multiplier_label: Label = $Views/MinesView/MinesLayoutHBox/ControlVBox/MultiplierLabel
@onready var mines_status_label: Label = $Views/MinesView/MinesLayoutHBox/ControlVBox/StatusLabel

# --- STATE ---
var current_bet: int = 100
var active_tab: String = "slots" # "slots", "coinflip", "mines"

# Slots Config
const SLOT_SYMBOLS = [
	{"sym": "🍒", "weight": 36, "mult": 3.0, "name": "Cherry"},
	{"sym": "🍋", "weight": 28, "mult": 5.0, "name": "Lemon"},
	{"sym": "🔔", "weight": 18, "mult": 10.0, "name": "Bell"},
	{"sym": "💎", "weight": 10, "mult": 25.0, "name": "Diamond"},
	{"sym": "👑", "weight": 5, "mult": 50.0, "name": "Crown"},
	{"sym": "7️⃣", "weight": 3, "mult": 100.0, "name": "JACKPOT 777"}
]
var is_spinning: bool = false

# Coin Flip Config
var chosen_coin_side: String = "heads" # "heads" or "tails"
var is_flipping: bool = false

# Mines Config
const TOTAL_TILES: int = 25
const MINES_COUNT: int = 3
const MINES_MULTIPLIERS = [
	1.15, 1.35, 1.62, 1.98, 2.46, 3.12, 4.02, 5.28, 7.08, 9.72, 13.68, 19.78, 29.68, 46.80, 78.50, 142.0, 280.0, 620.0, 1600.0, 5200.0, 22000.0, 120000.0
]
var mines_game_active: bool = false
var mines_locations: Array[int] = []
var revealed_tiles: Array[int] = []
var current_safe_gems: int = 0
var mines_buttons: Array[Button] = []

func _ready() -> void:
	# Tab buttons
	slots_tab_button.pressed.connect(func(): _switch_tab("slots"))
	coinflip_tab_button.pressed.connect(func(): _switch_tab("coinflip"))
	mines_tab_button.pressed.connect(func(): _switch_tab("mines"))
	
	# Bet chips
	chip_100_btn.pressed.connect(func(): _add_bet(100))
	chip_500_btn.pressed.connect(func(): _add_bet(500))
	chip_1k_btn.pressed.connect(func(): _add_bet(1000))
	chip_5k_btn.pressed.connect(func(): _add_bet(5000))
	chip_half_btn.pressed.connect(func(): _multiply_bet(0.5))
	chip_2x_btn.pressed.connect(func(): _multiply_bet(2.0))
	chip_max_btn.pressed.connect(_set_max_bet)
	chip_clear_btn.pressed.connect(_clear_bet)
	
	# Close button
	close_button.pressed.connect(_on_close_pressed)
	
	# Minigame 1: Slots
	spin_button.pressed.connect(_on_spin_pressed)
	
	# Minigame 2: Coin Flip
	heads_button.pressed.connect(func(): _select_coin_side("heads"))
	tails_button.pressed.connect(func(): _select_coin_side("tails"))
	flip_button.pressed.connect(_on_flip_pressed)
	_select_coin_side("heads")
	
	# Minigame 3: Mines
	start_mines_button.pressed.connect(_on_start_mines_pressed)
	cashout_button.pressed.connect(_on_cashout_mines_pressed)
	_setup_mines_grid()
	
	_switch_tab("slots")
	_update_ui()

func open_casino() -> void:
	visible = true
	_update_ui()
	_update_bet_display()

func _update_ui() -> void:
	if not is_inside_tree(): return
	casino_coins_label.text = "💰 YOUR COINS: %s" % _format_number(GameManager.total_coins)
	_update_bet_display()

func _update_bet_display() -> void:
	if not is_inside_tree(): return
	current_bet = clamp(current_bet, 50, max(50, GameManager.total_coins))
	bet_amount_label.text = "BET: $%s" % _format_number(current_bet)

func _add_bet(amount: int) -> void:
	if SoundManager: SoundManager.play_click()
	current_bet = min(GameManager.total_coins, current_bet + amount)
	_update_bet_display()

func _multiply_bet(factor: float) -> void:
	if SoundManager: SoundManager.play_click()
	current_bet = int(clamp(round(current_bet * factor), 50, max(50, GameManager.total_coins)))
	_update_bet_display()

func _set_max_bet() -> void:
	if SoundManager: SoundManager.play_click()
	current_bet = max(50, GameManager.total_coins)
	_update_bet_display()

func _clear_bet() -> void:
	if SoundManager: SoundManager.play_click()
	current_bet = 50
	_update_bet_display()

func _switch_tab(tab_name: String) -> void:
	if SoundManager: SoundManager.play_click()
	active_tab = tab_name
	slots_view.visible = (tab_name == "slots")
	coinflip_view.visible = (tab_name == "coinflip")
	mines_view.visible = (tab_name == "mines")
	
	# Tab highlights
	var accent_color = Color(1.0, 0.85, 0.2, 1.0)
	var normal_color = Color(0.7, 0.7, 0.7, 1.0)
	slots_tab_button.modulate = accent_color if tab_name == "slots" else normal_color
	coinflip_tab_button.modulate = accent_color if tab_name == "coinflip" else normal_color
	mines_tab_button.modulate = accent_color if tab_name == "mines" else normal_color

func _on_close_pressed() -> void:
	if SoundManager: SoundManager.play_click()
	if mines_game_active:
		# Auto-cashout if closing during active mines
		_on_cashout_mines_pressed()
	visible = false

# ==============================================================================
# MINIGAME 1: 🎰 LUCKY SLOTS
# ==============================================================================
func _on_spin_pressed() -> void:
	if is_spinning: return
	if GameManager.total_coins < current_bet:
		slots_status_label.text = "❌ NOT ENOUGH COINS!"
		slots_status_label.modulate = Color(1.0, 0.3, 0.3)
		if SoundManager: SoundManager.play_casino_lose()
		return
		
	# Deduct bet
	GameManager.total_coins -= current_bet
	GameManager.save_data()
	_update_ui()
	
	is_spinning = true
	spin_button.disabled = true
	slots_status_label.text = "🎰 SPINNING..."
	slots_status_label.modulate = Color(1.0, 0.85, 0.2)
	
	# Determine final outcomes based on weighted odds (House edge ~8.5%)
	var r1 = _get_weighted_slot_symbol()
	var r2 = _get_weighted_slot_symbol()
	var r3 = _get_weighted_slot_symbol()
	
	# Spin animation
	var tween = create_tween()
	var spin_duration = 1.6
	var all_syms = ["🍒", "🍋", "🔔", "💎", "👑", "7️⃣"]
	
	var elapsed = 0.0
	var interval = 0.08
	var steps = int(spin_duration / interval)
	
	for s in range(steps):
		tween.tween_callback(func():
			if SoundManager: SoundManager.play_casino_spin()
			if s < steps - 6:
				reel1_label.text = all_syms[randi() % all_syms.size()]
			else:
				reel1_label.text = r1["sym"]
				
			if s < steps - 3:
				reel2_label.text = all_syms[randi() % all_syms.size()]
			else:
				reel2_label.text = r2["sym"]
				
			reel3_label.text = all_syms[randi() % all_syms.size()]
		)
		tween.tween_interval(interval)
		
	tween.tween_callback(func():
		reel1_label.text = r1["sym"]
		reel2_label.text = r2["sym"]
		reel3_label.text = r3["sym"]
		_evaluate_slots_result(r1, r2, r3)
		is_spinning = false
		spin_button.disabled = false
	)

func _get_weighted_slot_symbol() -> Dictionary:
	var total_weight = 0
	for item in SLOT_SYMBOLS:
		total_weight += item["weight"]
		
	var roll = randi_range(1, total_weight)
	var cumulative = 0
	for item in SLOT_SYMBOLS:
		cumulative += item["weight"]
		if roll <= cumulative:
			return item
	return SLOT_SYMBOLS[0]

func _evaluate_slots_result(r1: Dictionary, r2: Dictionary, r3: Dictionary) -> void:
	if r1["sym"] == r2["sym"] and r2["sym"] == r3["sym"]:
		# 3 of a kind JACKPOT / BIG WIN
		var mult: float = r1["mult"]
		var payout: int = int(round(current_bet * mult))
		GameManager.total_coins += payout
		GameManager.save_data()
		_update_ui()
		
		slots_status_label.text = "🎉 %s! WIN: +$%s (x%.0f)" % [r1["name"].to_upper(), _format_number(payout), mult]
		slots_status_label.modulate = Color(0.2, 1.0, 0.4)
		if SoundManager: SoundManager.play_casino_win()
	elif r1["sym"] == r2["sym"] or r2["sym"] == r3["sym"] or r1["sym"] == r3["sym"]:
		# 2 matching symbols
		var mult: float = 1.5
		var payout: int = int(round(current_bet * mult))
		GameManager.total_coins += payout
		GameManager.save_data()
		_update_ui()
		
		slots_status_label.text = "✨ PAIR MATCH! WIN: +$%s (x1.5)" % _format_number(payout)
		slots_status_label.modulate = Color(0.4, 0.9, 1.0)
		if SoundManager: SoundManager.play_casino_win()
	else:
		slots_status_label.text = "💀 NO MATCH! -$%s" % _format_number(current_bet)
		slots_status_label.modulate = Color(1.0, 0.4, 0.4)
		if SoundManager: SoundManager.play_casino_lose()

# ==============================================================================
# MINIGAME 2: 🪙 COIN FLIP (Cara o Cruz)
# ==============================================================================
func _select_coin_side(side: String) -> void:
	if SoundManager: SoundManager.play_click()
	chosen_coin_side = side
	var accent = Color(1.0, 0.85, 0.2)
	var normal = Color(0.7, 0.7, 0.7)
	heads_button.modulate = accent if side == "heads" else normal
	tails_button.modulate = accent if side == "tails" else normal

func _on_flip_pressed() -> void:
	if is_flipping: return
	if GameManager.total_coins < current_bet:
		coinflip_status_label.text = "❌ NOT ENOUGH COINS!"
		coinflip_status_label.modulate = Color(1.0, 0.3, 0.3)
		if SoundManager: SoundManager.play_casino_lose()
		return
		
	GameManager.total_coins -= current_bet
	GameManager.save_data()
	_update_ui()
	
	is_flipping = true
	flip_button.disabled = true
	heads_button.disabled = true
	tails_button.disabled = true
	coinflip_status_label.text = "🪙 FLIPPING..."
	coinflip_status_label.modulate = Color(1.0, 0.85, 0.2)
	
	# Math: 48% chosen side, 48% opposite side, 4% STAR edge (House advantage)
	var roll = randf()
	var outcome_side = ""
	if roll < 0.48:
		outcome_side = chosen_coin_side # Win
	elif roll < 0.96:
		outcome_side = "tails" if chosen_coin_side == "heads" else "heads" # Loss
	else:
		outcome_side = "star" # House edge
		
	# Coin flipping animation
	var tween = create_tween()
	var flips = 12
	for i in range(flips):
		tween.tween_callback(func():
			if SoundManager: SoundManager.play_casino_spin()
			coin_symbol_label.text = "🦅" if (i % 2 == 0) else "👑"
			coin_display.scale.x = -1.0 if coin_display.scale.x > 0 else 1.0
		)
		tween.tween_interval(0.08)
		
	tween.tween_callback(func():
		coin_display.scale.x = 1.0
		if outcome_side == "heads":
			coin_symbol_label.text = "🦅"
		elif outcome_side == "tails":
			coin_symbol_label.text = "👑"
		else:
			coin_symbol_label.text = "⭐"
			
		_evaluate_coinflip_result(outcome_side)
		is_flipping = false
		flip_button.disabled = false
		heads_button.disabled = false
		tails_button.disabled = false
	)

func _evaluate_coinflip_result(outcome: String) -> void:
	if outcome == chosen_coin_side:
		var payout: int = int(round(current_bet * 1.95))
		GameManager.total_coins += payout
		GameManager.save_data()
		_update_ui()
		
		coinflip_status_label.text = "🎉 YOU WON! +$%s (x1.95)" % _format_number(payout)
		coinflip_status_label.modulate = Color(0.2, 1.0, 0.4)
		if SoundManager: SoundManager.play_casino_win()
	elif outcome == "star":
		coinflip_status_label.text = "⭐ STAR EDGE (HOUSE WINS)! -$%s" % _format_number(current_bet)
		coinflip_status_label.modulate = Color(1.0, 0.4, 0.4)
		if SoundManager: SoundManager.play_casino_lose()
	else:
		coinflip_status_label.text = "💀 WRONG SIDE! -$%s" % _format_number(current_bet)
		coinflip_status_label.modulate = Color(1.0, 0.4, 0.4)
		if SoundManager: SoundManager.play_casino_lose()

# ==============================================================================
# MINIGAME 3: 💣 MINES (Buscaminas)
# ==============================================================================
func _setup_mines_grid() -> void:
	for child in mines_grid.get_children():
		child.queue_free()
	mines_buttons.clear()
	
	for i in range(TOTAL_TILES):
		var btn = Button.new()
		btn.custom_minimum_size = Vector2(56, 56)
		btn.text = "❓"
		btn.add_theme_font_size_override("font_size", 22)
		var idx = i
		btn.pressed.connect(func(): _on_mine_tile_clicked(idx))
		mines_grid.add_child(btn)
		mines_buttons.append(btn)
		
	cashout_button.visible = false
	current_multiplier_label.text = "MULTIPLIER: x1.00"

func _on_start_mines_pressed() -> void:
	if GameManager.total_coins < current_bet:
		mines_status_label.text = "❌ NOT ENOUGH COINS!"
		mines_status_label.modulate = Color(1.0, 0.3, 0.3)
		if SoundManager: SoundManager.play_casino_lose()
		return
		
	GameManager.total_coins -= current_bet
	GameManager.save_data()
	_update_ui()
	
	# Initialize mines game
	mines_game_active = true
	revealed_tiles.clear()
	current_safe_gems = 0
	
	# Randomly place 3 hidden mines
	mines_locations.clear()
	while mines_locations.size() < MINES_COUNT:
		var pos = randi() % TOTAL_TILES
		if pos not in mines_locations:
			mines_locations.append(pos)
			
	# Reset buttons
	for btn in mines_buttons:
		btn.disabled = false
		btn.text = "❓"
		btn.modulate = Color(1.0, 1.0, 1.0)
		
	start_mines_button.visible = false
	cashout_button.visible = true
	cashout_button.text = "💰 CASHOUT: $%s" % _format_number(current_bet)
	current_multiplier_label.text = "NEXT GEM: x%.2f" % MINES_MULTIPLIERS[0]
	mines_status_label.text = "💎 FIND GEMS, AVOID THE 3 MINES!"
	mines_status_label.modulate = Color(1.0, 0.85, 0.2)
	
	if SoundManager: SoundManager.play_click()

func _on_mine_tile_clicked(idx: int) -> void:
	if not mines_game_active or idx in revealed_tiles: return
	revealed_tiles.append(idx)
	
	var btn = mines_buttons[idx]
	btn.disabled = true
	
	if idx in mines_locations:
		# HIT A MINE! BOOM!
		mines_game_active = false
		btn.text = "💣"
		btn.modulate = Color(1.0, 0.2, 0.2)
		
		# Reveal all other mines
		for m in mines_locations:
			mines_buttons[m].text = "💣"
			mines_buttons[m].modulate = Color(1.0, 0.4, 0.4)
			
		for b in mines_buttons:
			b.disabled = true
			
		cashout_button.visible = false
		start_mines_button.visible = true
		current_multiplier_label.text = "💥 BOOM! MULTIPLIER LOST"
		mines_status_label.text = "💀 YOU HIT A MINE! -$%s" % _format_number(current_bet)
		mines_status_label.modulate = Color(1.0, 0.3, 0.3)
		
		if SoundManager: SoundManager.play_explosion()
	else:
		# SAFE GEM FOUND!
		current_safe_gems += 1
		btn.text = "💎"
		btn.modulate = Color(0.3, 1.0, 0.5)
		
		var mult_idx = min(current_safe_gems - 1, MINES_MULTIPLIERS.size() - 1)
		var current_mult: float = MINES_MULTIPLIERS[mult_idx]
		var potential_payout: int = int(round(current_bet * current_mult))
		
		var next_mult_idx = min(current_safe_gems, MINES_MULTIPLIERS.size() - 1)
		var next_mult: float = MINES_MULTIPLIERS[next_mult_idx]
		
		current_multiplier_label.text = "MULTIPLIER: x%.2f | NEXT: x%.2f" % [current_mult, next_mult]
		cashout_button.text = "💰 CASHOUT: $%s (x%.2f)" % [_format_number(potential_payout), current_mult]
		mines_status_label.text = "💎 GEM %d/22! Cashout or keep risking?" % current_safe_gems
		mines_status_label.modulate = Color(0.2, 1.0, 0.6)
		
		if SoundManager: SoundManager.play_coin()

func _on_cashout_mines_pressed() -> void:
	if not mines_game_active or current_safe_gems == 0: return
	mines_game_active = false
	
	var mult_idx = min(current_safe_gems - 1, MINES_MULTIPLIERS.size() - 1)
	var current_mult: float = MINES_MULTIPLIERS[mult_idx]
	var payout: int = int(round(current_bet * current_mult))
	
	GameManager.total_coins += payout
	GameManager.save_data()
	_update_ui()
	
	# Reveal all remaining tiles
	for i in range(TOTAL_TILES):
		if i not in revealed_tiles:
			if i in mines_locations:
				mines_buttons[i].text = "💣"
				mines_buttons[i].modulate = Color(1.0, 0.5, 0.5)
			else:
				mines_buttons[i].text = "💎"
				mines_buttons[i].modulate = Color(0.6, 0.8, 0.6)
		mines_buttons[i].disabled = true
		
	cashout_button.visible = false
	start_mines_button.visible = true
	mines_status_label.text = "🎉 CASHOUT SUCCESSFUL! +$%s (x%.2f)" % [_format_number(payout), current_mult]
	mines_status_label.modulate = Color(0.2, 1.0, 0.4)
	
	if SoundManager: SoundManager.play_casino_win()

func _format_number(n: int) -> String:
	var s = str(n)
	var formatted = ""
	var count = 0
	for i in range(s.length() - 1, -1, -1):
		if count > 0 and count % 3 == 0:
			formatted = "," + formatted
		formatted = s[i] + formatted
		count += 1
	return formatted
