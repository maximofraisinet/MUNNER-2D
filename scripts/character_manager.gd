extends Node

signal character_changed(character: CharacterData)
signal unlocked_characters_changed
signal boost_inventory_changed

var current_character_id: String = "tired"
var characters: Dictionary = {}
var unlocked_characters: Array = ["tired"]

## Inventario de Boosts y Slots Equipados (Hasta 3 Slots)
var boost_inventory: Dictionary = {
	"shield_boost": 0,
	"life_boost": 0,
	"slow_boost": 0,
	"fly_boost": 0
}
var equipped_boost_slots: Array = ["", "", ""]

const SAVE_PATH = "user://savegame.cfg"

func _ready() -> void:
	_register_characters()
	load_data()

func _register_characters() -> void:
	# 1. TIRED (Tier 1 - Starter)
	var tired = CharacterData.new()
	tired.id = "tired"
	tired.display_name = "TIRED"
	tired.tier_rank = 1
	tired.price = 0 # Starter gratuito
	tired.boost_slots = 0
	tired.pros_description = "+10% Score bonus per second"
	tired.cons_description = "+10% Faster base jump fall"
	tired.sprite_scale = Vector2(0.13, 0.13)
	tired.sprite_offset = Vector2(0, -20)
	var tired_paths = [
		"res://assets/characters/tired/run1.png", "res://assets/characters/tired/run2.png",
		"res://assets/characters/tired/run3.png", "res://assets/characters/tired/run4.png",
		"res://assets/characters/tired/run5.png", "res://assets/characters/tired/run6.png"
	]
	for path in tired_paths:
		var tex = load(path) as Texture2D
		if tex: tired.run_frames.append(tex)
	if tired.run_frames.size() > 2: tired.jump_frame = tired.run_frames[2]
	characters["tired"] = tired

	# 2. LEECH (Tier 2 - 1st Buyable)
	var leech = CharacterData.new()
	leech.id = "leech"
	leech.display_name = "LEECH"
	leech.tier_rank = 2
	leech.price = 500
	leech.boost_slots = 0
	leech.pros_description = "+20% Shield Duration (6.0s duration)"
	leech.cons_description = "-15% Coin spawn chance"
	leech.sprite_scale = Vector2(0.13, 0.13)
	leech.sprite_offset = Vector2(0, -20)
	var leech_paths = [
		"res://assets/characters/leech/run1.png", "res://assets/characters/leech/run2.png",
		"res://assets/characters/leech/run3.png", "res://assets/characters/leech/run4.png",
		"res://assets/characters/leech/run5.png", "res://assets/characters/leech/run6.png"
	]
	for path in leech_paths:
		var tex = load(path) as Texture2D
		if tex: leech.run_frames.append(tex)
	if leech.run_frames.size() > 2: leech.jump_frame = leech.run_frames[2]
	characters["leech"] = leech

	# 3. MAXIMO (Tier 3 - 2nd Buyable)
	var maximo = CharacterData.new()
	maximo.id = "maximo"
	maximo.display_name = "MAXIMO"
	maximo.tier_rank = 3
	maximo.price = 1500
	maximo.boost_slots = 0
	maximo.pros_description = "-50% Negative items drop rate"
	maximo.cons_description = "-10% Run score multiplier"
	maximo.negative_spawn_multiplier = 0.5
	maximo.sprite_scale = Vector2(0.13, 0.13)
	maximo.sprite_offset = Vector2(0, -20)
	var maximo_paths = [
		"res://assets/characters/maximo/run1.png", "res://assets/characters/maximo/run2.png",
		"res://assets/characters/maximo/run3.png", "res://assets/characters/maximo/run4.png",
		"res://assets/characters/maximo/run5.png", "res://assets/characters/maximo/run6.png"
	]
	for path in maximo_paths:
		var tex = load(path) as Texture2D
		if tex: maximo.run_frames.append(tex)
	if maximo.run_frames.size() > 2: maximo.jump_frame = maximo.run_frames[2]
	characters["maximo"] = maximo

	# 4. OMABLO (Tier 4)
	var omablo = CharacterData.new()
	omablo.id = "omablo"
	omablo.display_name = "OMABLO"
	omablo.tier_rank = 4
	omablo.price = 3500
	omablo.boost_slots = 0
	omablo.pros_description = "+150% EXTRA LIFE drop rate"
	omablo.cons_description = "+30% Turbo Debuff drop rate"
	omablo.life_spawn_multiplier = 2.5
	omablo.sprite_scale = Vector2(0.115, 0.115)
	omablo.sprite_offset = Vector2(0, -20)
	var omablo_paths = [
		"res://assets/characters/omablo/run1.png", "res://assets/characters/omablo/run2.png",
		"res://assets/characters/omablo/run3.png", "res://assets/characters/omablo/run4.png",
		"res://assets/characters/omablo/run5.png", "res://assets/characters/omablo/run6.png"
	]
	for path in omablo_paths:
		var tex = load(path) as Texture2D
		if tex: omablo.run_frames.append(tex)
	if omablo.run_frames.size() > 2: omablo.jump_frame = omablo.run_frames[2]
	characters["omablo"] = omablo

	# 5. DEMON (Tier 5 - Premium)
	var demon = CharacterData.new()
	demon.id = "demon"
	demon.display_name = "DEMON ★"
	demon.tier_rank = 5
	demon.price = 7500
	demon.boost_slots = 1 # 1 Boost Slot activo
	demon.pros_description = "+150% Extra Life, +100% Fly & -50% Debuffs"
	demon.cons_description = "None (Premium Perk Tier)"
	demon.life_spawn_multiplier = 2.5
	demon.fly_spawn_multiplier = 2.0
	demon.negative_spawn_multiplier = 0.5
	demon.sprite_scale = Vector2(0.14, 0.14)
	demon.sprite_offset = Vector2(0, -20)
	var demon_paths = [
		"res://assets/characters/demon/run1.png", "res://assets/characters/demon/run2.png",
		"res://assets/characters/demon/run3.png", "res://assets/characters/demon/run4.png",
		"res://assets/characters/demon/run5.png", "res://assets/characters/demon/run7.png"
	]
	for path in demon_paths:
		var tex = load(path) as Texture2D
		if tex: demon.run_frames.append(tex)
	if demon.run_frames.size() > 2: demon.jump_frame = demon.run_frames[2]
	characters["demon"] = demon

	# 6. MESSI (Tier 6 - GOAT Tier)
	var messi = CharacterData.new()
	messi.id = "messi"
	messi.display_name = "MESSI 👑"
	messi.tier_rank = 6
	messi.price = 15000
	messi.boost_slots = 2 # 2 Boost Slots activos!
	messi.pros_description = "PRO: 0% Negative items drop (No Debuffs!)"
	messi.cons_description = "CON: Standard positive item drop rates"
	messi.negative_spawn_multiplier = 0.0 # 0% debuffs!
	messi.life_spawn_multiplier = 1.0
	messi.fly_spawn_multiplier = 1.0
	messi.sprite_scale = Vector2(0.13, 0.13)
	messi.sprite_offset = Vector2(0, -20)
	var messi_paths = [
		"res://assets/characters/messi/run1.png", "res://assets/characters/messi/run2.png",
		"res://assets/characters/messi/run3.png", "res://assets/characters/messi/run4.png",
		"res://assets/characters/messi/run5.png", "res://assets/characters/messi/run6.png"
	]
	for path in messi_paths:
		var tex = load(path) as Texture2D
		if tex: messi.run_frames.append(tex)
	if messi.run_frames.size() > 2: messi.jump_frame = messi.run_frames[2]
	characters["messi"] = messi

	# 7. DARK ANGEL (Tier 7 - Celestial Ultimate)
	var dark_angel = CharacterData.new()
	dark_angel.id = "dark_angel"
	dark_angel.display_name = "DARK ANGEL ⚡"
	dark_angel.tier_rank = 7
	dark_angel.price = 30000
	dark_angel.boost_slots = 3 # 3 MAX Boost Slots activos!
	dark_angel.pros_description = "PRO: +300% Fly drop rate & 3 Slots"
	dark_angel.cons_description = "CON: +50% Turbo Debuff drop rate"
	dark_angel.fly_spawn_multiplier = 4.0 # +300% fly drop!
	dark_angel.life_spawn_multiplier = 1.5
	dark_angel.negative_spawn_multiplier = 1.5
	dark_angel.sprite_scale = Vector2(0.14, 0.14)
	dark_angel.sprite_offset = Vector2(0, -20)
	var dark_angel_paths = [
		"res://assets/characters/dark_angel/run1.png", "res://assets/characters/dark_angel/run2.png",
		"res://assets/characters/dark_angel/run3.png", "res://assets/characters/dark_angel/run4.png",
		"res://assets/characters/dark_angel/run5.png", "res://assets/characters/dark_angel/run6.png"
	]
	for path in dark_angel_paths:
		var tex = load(path) as Texture2D
		if tex: dark_angel.run_frames.append(tex)
	if dark_angel.run_frames.size() > 2: dark_angel.jump_frame = dark_angel.run_frames[2]
	characters["dark_angel"] = dark_angel

	# 8. DEMON MESSI (Tier 8 - GOD OF ALL CHARACTERS)
	var demon_messi = CharacterData.new()
	demon_messi.id = "demon_messi"
	demon_messi.display_name = "DEMON MESSI 👑🔥"
	demon_messi.tier_rank = 8
	demon_messi.price = 50000 # Ultimate Endgame GOD Tier
	demon_messi.boost_slots = 3 # 3 MAX Boost Slots
	demon_messi.pros_description = "PRO: PERMA-SHIELD, +5 LIVES, MAGNET, 0% DEBUFFS"
	demon_messi.cons_description = "CON: NONE (UNSTOPPABLE GOD TIER)"
	demon_messi.negative_spawn_multiplier = 0.0 # 0% debuffs!
	demon_messi.life_spawn_multiplier = 5.0    # +400% Extra Lives!
	demon_messi.fly_spawn_multiplier = 5.0     # +400% Fly items!
	demon_messi.sprite_scale = Vector2(0.14, 0.14)
	demon_messi.sprite_offset = Vector2(0, -20)
	var demon_messi_paths = [
		"res://assets/characters/demon_messi/run1.png", "res://assets/characters/demon_messi/run2.png",
		"res://assets/characters/demon_messi/run3.png", "res://assets/characters/demon_messi/run4.png",
		"res://assets/characters/demon_messi/run5.png", "res://assets/characters/demon_messi/run6.png"
	]
	for path in demon_messi_paths:
		var tex = load(path) as Texture2D
		if tex: demon_messi.run_frames.append(tex)
	if demon_messi.run_frames.size() > 2: demon_messi.jump_frame = demon_messi.run_frames[2]
	characters["demon_messi"] = demon_messi

func get_current_character() -> CharacterData:
	if characters.has(current_character_id):
		return characters[current_character_id]
	if characters.size() > 0:
		return characters.values()[0]
	return null

func is_unlocked(id: String) -> bool:
	return unlocked_characters.has(id)

func buy_character(id: String) -> bool:
	if is_unlocked(id):
		return true
	if characters.has(id):
		var char_data = characters[id] as CharacterData
		if GameManager.total_coins >= char_data.price:
			GameManager.total_coins -= char_data.price
			unlocked_characters.append(id)
			save_data()
			GameManager.save_data()
			unlocked_characters_changed.emit()
			return true
	return false

func select_character(id: String) -> void:
	if is_unlocked(id) and characters.has(id):
		current_character_id = id
		save_data()
		character_changed.emit(get_current_character())

func get_boost_price(boost_id: String) -> int:
	match boost_id:
		"shield_boost": return 100
		"slow_boost": return 150
		"life_boost": return 200
		"fly_boost": return 250
		_: return 100

func buy_boost(boost_id: String) -> bool:
	var price = get_boost_price(boost_id)
	if GameManager.total_coins >= price:
		GameManager.total_coins -= price
		boost_inventory[boost_id] = boost_inventory.get(boost_id, 0) + 1
		GameManager.save_data()
		save_data()
		boost_inventory_changed.emit()
		return true
	return false

func equip_boost_to_slot(slot_idx: int, boost_id: String) -> bool:
	var curr = get_current_character()
	if curr and slot_idx < curr.boost_slots:
		if equipped_boost_slots[slot_idx] == boost_id:
			equipped_boost_slots[slot_idx] = "" # Desequipar
		else:
			equipped_boost_slots[slot_idx] = boost_id
		save_data()
		boost_inventory_changed.emit()
		return true
	return false

func get_boost_qty(boost_id: String) -> int:
	return boost_inventory.get(boost_id, 0)

func save_data() -> void:
	var config = ConfigFile.new()
	config.set_value("character", "current", current_character_id)
	config.set_value("character", "unlocked", unlocked_characters)
	config.set_value("character", "boost_inventory", boost_inventory)
	config.set_value("character", "equipped_boost_slots", equipped_boost_slots)
	config.save(SAVE_PATH)

func load_data() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		current_character_id = config.get_value("character", "current", "tired")
		unlocked_characters = config.get_value("character", "unlocked", ["tired"])
		boost_inventory = config.get_value("character", "boost_inventory", {"shield_boost": 0, "life_boost": 0, "slow_boost": 0, "fly_boost": 0})
		equipped_boost_slots = config.get_value("character", "equipped_boost_slots", ["", "", ""])
