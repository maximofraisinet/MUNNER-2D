extends Node

const SAVE_PATH = "user://savegame.cfg"

var jump_sfx: AudioStream
var coin_sfx: AudioStream
var powerup_pos_sfx: AudioStream
var powerup_neg_sfx: AudioStream
var fly_sfx: AudioStream
var footstep1_sfx: AudioStream
var footstep2_sfx: AudioStream
var shield_hit_sfx: AudioStream
var game_over_sfx: AudioStream
var click_sfx: AudioStream
var casino_win_sfx: AudioStream
var casino_lose_sfx: AudioStream
var casino_spin_sfx: AudioStream
var explosion_sfx: AudioStream

var players: Array[AudioStreamPlayer] = []
var max_players: int = 10
var current_player_idx: int = 0

var sfx_volume: float = 0.8
var footstep_step: int = 0

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	load_data()
	
	jump_sfx = load("res://assets/sfx/jump.wav")
	coin_sfx = load("res://assets/sfx/coin.wav")
	powerup_pos_sfx = load("res://assets/sfx/powerup_positive.wav")
	powerup_neg_sfx = load("res://assets/sfx/powerup_negative.wav")
	fly_sfx = load("res://assets/sfx/fly.wav")
	footstep1_sfx = load("res://assets/sfx/footstep1.wav")
	footstep2_sfx = load("res://assets/sfx/footstep2.wav")
	shield_hit_sfx = load("res://assets/sfx/shield_hit.wav")
	game_over_sfx = load("res://assets/sfx/game_over.wav")
	click_sfx = load("res://assets/sfx/click.wav")
	casino_win_sfx = load("res://assets/sfx/casino_win.wav")
	casino_lose_sfx = load("res://assets/sfx/casino_lose.wav")
	casino_spin_sfx = load("res://assets/sfx/casino_spin.wav")
	explosion_sfx = load("res://assets/sfx/explosion.wav")
	
	for i in range(max_players):
		var p = AudioStreamPlayer.new()
		p.bus = "Master"
		add_child(p)
		players.append(p)

func _get_available_player() -> AudioStreamPlayer:
	var p = players[current_player_idx]
	current_player_idx = (current_player_idx + 1) % max_players
	return p

func _play_stream(stream: AudioStream, vol_scale: float = 1.0, pitch_scale: float = 1.0) -> void:
	if not stream or sfx_volume <= 0.001:
		return
	var p = _get_available_player()
	p.stream = stream
	p.pitch_scale = pitch_scale
	var final_vol = sfx_volume * vol_scale
	p.volume_db = linear_to_db(max(0.001, final_vol))
	p.play()

func play_jump() -> void:
	_play_stream(jump_sfx, 0.9, randf_range(0.96, 1.04))

func play_coin() -> void:
	_play_stream(coin_sfx, 0.85, randf_range(0.98, 1.05))

func play_powerup_positive() -> void:
	_play_stream(powerup_pos_sfx, 1.0, 1.0)

func play_powerup_negative() -> void:
	_play_stream(powerup_neg_sfx, 1.0, 1.0)

func play_fly() -> void:
	_play_stream(fly_sfx, 0.9, 1.0)

func play_footstep() -> void:
	footstep_step += 1
	var s = footstep1_sfx if (footstep_step % 2 == 0) else footstep2_sfx
	_play_stream(s, 0.45, randf_range(0.9, 1.1))

func play_shield_hit() -> void:
	_play_stream(shield_hit_sfx, 0.95, randf_range(0.95, 1.05))

func play_game_over() -> void:
	_play_stream(game_over_sfx, 1.0, 1.0)

func play_click() -> void:
	_play_stream(click_sfx, 0.7, randf_range(0.98, 1.02))

func play_casino_win() -> void:
	_play_stream(casino_win_sfx, 1.0, 1.0)

func play_casino_lose() -> void:
	_play_stream(casino_lose_sfx, 0.9, 1.0)

func play_casino_spin() -> void:
	_play_stream(casino_spin_sfx, 0.6, randf_range(0.95, 1.05))

func play_explosion() -> void:
	_play_stream(explosion_sfx, 1.0, randf_range(0.95, 1.05))

func set_sfx_volume(val: float) -> void:
	sfx_volume = clamp(val, 0.0, 1.0)
	save_data()

func load_data() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		sfx_volume = config.get_value("audio", "sfx_volume", 0.8)

func save_data() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value("audio", "sfx_volume", sfx_volume)
	config.save(SAVE_PATH)
