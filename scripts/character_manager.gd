extends Node

var current_character_id: String = "demon"
var characters: Dictionary = {}

func _ready() -> void:
	_register_characters()

func _register_characters() -> void:
	var demon = CharacterData.new()
	demon.id = "demon"
	demon.display_name = "Demon"
	demon.sprite_scale = Vector2(0.07, 0.07)
	demon.sprite_offset = Vector2(0, -10)
	
	var frame_paths = [
		"res://assets/characters/demon/run1.png",
		"res://assets/characters/demon/run2.png",
		"res://assets/characters/demon/run3.png",
		"res://assets/characters/demon/run4.png",
		"res://assets/characters/demon/run5.png",
		"res://assets/characters/demon/run7.png"
	]
	
	for path in frame_paths:
		var tex = load(path) as Texture2D
		if tex:
			demon.run_frames.append(tex)
			
	if demon.run_frames.size() > 2:
		demon.jump_frame = demon.run_frames[2]
	elif demon.run_frames.size() > 0:
		demon.jump_frame = demon.run_frames[0]
		
	characters["demon"] = demon

func get_current_character() -> CharacterData:
	if characters.has(current_character_id):
		return characters[current_character_id]
	if characters.size() > 0:
		return characters.values()[0]
	return null

func register_character(data: CharacterData) -> void:
	characters[data.id] = data

func select_character(id: String) -> void:
	if characters.has(id):
		current_character_id = id
