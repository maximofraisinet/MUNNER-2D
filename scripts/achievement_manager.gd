extends Node

signal achievement_unlocked(id: String)
signal achievement_claimed(id: String, reward: int)

const SAVE_PATH = "user://savegame.cfg"

const ACHIEVEMENTS = [
	{
		"id": "score_500",
		"title": "ROOKIE RUNNER",
		"desc": "Reach a score of 500",
		"target_score": 500,
		"reward": 100
	},
	{
		"id": "score_1000",
		"title": "SKILLED SPRINTER",
		"desc": "Reach a score of 1,000",
		"target_score": 1000,
		"reward": 200
	},
	{
		"id": "score_1500",
		"title": "GOLDEN STRIDER",
		"desc": "Reach a score of 1,500",
		"target_score": 1500,
		"reward": 500
	},
	{
		"id": "score_3000",
		"title": "OBSTACLE MASTER",
		"desc": "Reach a score of 3,000",
		"target_score": 3000,
		"reward": 1000
	},
	{
		"id": "score_5000",
		"title": "SUPER DASH CHAMPION",
		"desc": "Reach a score of 5,000",
		"target_score": 5000,
		"reward": 3500
	},
	{
		"id": "score_10000",
		"title": "SPEED GOD",
		"desc": "Reach a score of 10,000",
		"target_score": 10000,
		"reward": 10000
	},
	{
		"id": "score_20000",
		"title": "UNSTOPPABLE LEGEND",
		"desc": "Reach a score of 20,000",
		"target_score": 20000,
		"reward": 25000
	}
]

var claimed_achievements: Array = []

func _ready() -> void:
	load_data()

func is_unlocked(id: String) -> bool:
	for ach in ACHIEVEMENTS:
		if ach["id"] == id:
			return GameManager.high_score >= ach["target_score"]
	return false

func is_claimed(id: String) -> bool:
	return id in claimed_achievements

func can_claim(id: String) -> bool:
	return is_unlocked(id) and not is_claimed(id)

func claim_achievement(id: String) -> bool:
	for ach in ACHIEVEMENTS:
		if ach["id"] == id:
			if can_claim(id):
				claimed_achievements.append(id)
				var reward = ach["reward"]
				GameManager.total_coins += reward
				GameManager.save_data()
				save_data()
				achievement_claimed.emit(id, reward)
				return true
	return false

func get_unclaimed_count() -> int:
	var count = 0
	for ach in ACHIEVEMENTS:
		if can_claim(ach["id"]):
			count += 1
	return count

func save_data() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value("achievements", "claimed", claimed_achievements)
	config.save(SAVE_PATH)

func load_data() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		claimed_achievements = config.get_value("achievements", "claimed", [])

func wipe_all_data() -> void:
	claimed_achievements = []
	save_data()
