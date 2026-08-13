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
