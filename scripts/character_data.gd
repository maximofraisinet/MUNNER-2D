extends Resource
class_name CharacterData

@export var id: String = ""
@export var display_name: String = ""
@export var sprite_scale: Vector2 = Vector2(0.14, 0.14)
@export var sprite_offset: Vector2 = Vector2.ZERO

@export var run_frames: Array[Texture2D] = []
@export var jump_frame: Texture2D

@export var price: int = 1
@export var tier_rank: int = 1
@export var boost_slots: int = 0
@export var coin_multiplier: int = 1
@export var pros_description: String = ""
@export var cons_description: String = ""

## Spawn chance multipliers
@export var life_spawn_multiplier: float = 1.0
@export var fly_spawn_multiplier: float = 1.0
@export var negative_spawn_multiplier: float = 1.0
