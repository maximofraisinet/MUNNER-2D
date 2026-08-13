extends Node

signal playlist_changed(playlist_name: String)
signal volume_changed(volume_percent: float)
signal track_changed(track_title: String)

var playlists: Dictionary = {
	"electro": [
		"res://assets/music/electro1.mp3",
		"res://assets/music/electro2.mp3"
	],
	"hard": [
		"res://assets/music/hard1.mp3",
		"res://assets/music/hard2.mp3"
	],
	"epic": [
		"res://assets/music/epic1.mp3",
		"res://assets/music/epic2.mp3"
	],
	"argenta": [
		"res://assets/music/argenta1.mp3",
		"res://assets/music/argenta2.mp3",
		"res://assets/music/argenta3.mp3"
	]
}

var current_playlist: String = "electro"
var current_track_index: int = 0
var music_volume: float = 0.7

var player: AudioStreamPlayer
const SAVE_PATH = "user://savegame.cfg"

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	
	player = AudioStreamPlayer.new()
	player.bus = "Master"
	player.finished.connect(_on_player_finished)
	add_child(player)
	
	load_data()
	_apply_volume()
	
	# Start playing the configured playlist
	if current_playlist != "off":
		_play_current_track()

func load_data() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		current_playlist = config.get_value("audio", "playlist", "electro")
		music_volume = config.get_value("audio", "volume", 0.7)

func save_data() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value("audio", "playlist", current_playlist)
	config.set_value("audio", "volume", music_volume)
	config.save(SAVE_PATH)

func set_playlist(playlist_name: String) -> void:
	if current_playlist == playlist_name and player.playing:
		return
		
	current_playlist = playlist_name
	current_track_index = 0
	save_data()
	playlist_changed.emit(current_playlist)
	
	if current_playlist == "off":
		player.stop()
	else:
		_play_current_track()

func set_volume(val: float) -> void:
	music_volume = clamp(val, 0.0, 1.0)
	_apply_volume()
	save_data()
	volume_changed.emit(music_volume)

func _apply_volume() -> void:
	if not player:
		return
	if music_volume <= 0.001:
		player.volume_db = -80.0
	else:
		player.volume_db = linear_to_db(music_volume)

func _play_current_track() -> void:
	if current_playlist == "off" or not playlists.has(current_playlist):
		return
		
	var tracks: Array = playlists[current_playlist]
	if tracks.size() == 0:
		return
		
	if current_track_index >= tracks.size():
		current_track_index = 0
		
	var track_path: String = tracks[current_track_index]
	var stream = load(track_path) as AudioStream
	if stream:
		player.stream = stream
		_apply_volume()
		player.play()
		track_changed.emit(track_path.get_file().get_basename())

func _on_player_finished() -> void:
	if current_playlist == "off" or not playlists.has(current_playlist):
		return
		
	var tracks: Array = playlists[current_playlist]
	if tracks.size() > 0:
		current_track_index = (current_track_index + 1) % tracks.size()
		_play_current_track()
