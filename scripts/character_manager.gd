extends Node

signal character_changed(character: CharacterData)

var current_character_id: String = "demon"
var characters: Dictionary = {}

func _ready() -> void:
	_register_characters()

func _register_characters() -> void:
	# Personaje 1: DEMON
	var demon = CharacterData.new()
	demon.id = "demon"
	demon.display_name = "DEMON"
	demon.sprite_scale = Vector2(0.14, 0.14)
	demon.sprite_offset = Vector2(0, -20)
	
	var demon_paths = [
		"res://assets/characters/demon/run1.png",
		"res://assets/characters/demon/run2.png",
		"res://assets/characters/demon/run3.png",
		"res://assets/characters/demon/run4.png",
		"res://assets/characters/demon/run5.png",
		"res://assets/characters/demon/run7.png"
	]
	for path in demon_paths:
		var tex = load(path) as Texture2D
		if tex:
			demon.run_frames.append(tex)
	if demon.run_frames.size() > 2:
		demon.jump_frame = demon.run_frames[2]
	characters["demon"] = demon

	# Personaje 2: TIRED
	var tired = CharacterData.new()
	tired.id = "tired"
	tired.display_name = "TIRED"
	tired.sprite_scale = Vector2(0.13, 0.13)
	tired.sprite_offset = Vector2(0, -20)
	
	var tired_paths = [
		"res://assets/characters/tired/run1.png",
		"res://assets/characters/tired/run2.png",
		"res://assets/characters/tired/run3.png",
		"res://assets/characters/tired/run4.png",
		"res://assets/characters/tired/run5.png",
		"res://assets/characters/tired/run6.png"
	]
	for path in tired_paths:
		var tex = load(path) as Texture2D
		if tex:
			tired.run_frames.append(tex)
	if tired.run_frames.size() > 2:
		tired.jump_frame = tired.run_frames[2]
	characters["tired"] = tired

	# Personaje 3: LEECH
	var leech = CharacterData.new()
	leech.id = "leech"
	leech.display_name = "LEECH"
	leech.sprite_scale = Vector2(0.13, 0.13)
	leech.sprite_offset = Vector2(0, -20)
	
	var leech_paths = [
		"res://assets/characters/leech/run1.png",
		"res://assets/characters/leech/run2.png",
		"res://assets/characters/leech/run3.png",
		"res://assets/characters/leech/run4.png",
		"res://assets/characters/leech/run5.png",
		"res://assets/characters/leech/run6.png"
	]
	for path in leech_paths:
		var tex = load(path) as Texture2D
		if tex:
			leech.run_frames.append(tex)
	if leech.run_frames.size() > 2:
		leech.jump_frame = leech.run_frames[2]
	characters["leech"] = leech

	# Personaje 4: MAXIMO
	var maximo = CharacterData.new()
	maximo.id = "maximo"
	maximo.display_name = "MAXIMO"
	maximo.sprite_scale = Vector2(0.13, 0.13)
	maximo.sprite_offset = Vector2(0, -20)
	
	var maximo_paths = [
		"res://assets/characters/maximo/run1.png",
		"res://assets/characters/maximo/run2.png",
		"res://assets/characters/maximo/run3.png",
		"res://assets/characters/maximo/run4.png",
		"res://assets/characters/maximo/run5.png",
		"res://assets/characters/maximo/run6.png"
	]
	for path in maximo_paths:
		var tex = load(path) as Texture2D
		if tex:
			maximo.run_frames.append(tex)
	if maximo.run_frames.size() > 2:
		maximo.jump_frame = maximo.run_frames[2]
	characters["maximo"] = maximo

	# Personaje 5: OMABLO
	var omablo = CharacterData.new()
	omablo.id = "omablo"
	omablo.display_name = "OMABLO"
	omablo.sprite_scale = Vector2(0.115, 0.115)
	omablo.sprite_offset = Vector2(0, -20)
	
	var omablo_paths = [
		"res://assets/characters/omablo/run1.png",
		"res://assets/characters/omablo/run2.png",
		"res://assets/characters/omablo/run3.png",
		"res://assets/characters/omablo/run4.png",
		"res://assets/characters/omablo/run5.png",
		"res://assets/characters/omablo/run6.png"
	]
	for path in omablo_paths:
		var tex = load(path) as Texture2D
		if tex:
			omablo.run_frames.append(tex)
	if omablo.run_frames.size() > 2:
		omablo.jump_frame = omablo.run_frames[2]
	characters["omablo"] = omablo

func get_current_character() -> CharacterData:
	if characters.has(current_character_id):
		return characters[current_character_id]
	if characters.size() > 0:
		return characters.values()[0]
	return null

func select_character(id: String) -> void:
	if characters.has(id):
		current_character_id = id
		character_changed.emit(get_current_character())
