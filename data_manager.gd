extends Node
const save_file = "user://SaveFile.json"
var save_data: Dictionary = {
	"player_party": [],
	"story_progress": 0,
	"player_location" : "res://starter_area.tscn"
	}

func _ready() -> void:
	pass

func save_game():
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	file.store_var(save_data.duplicate())
	file.close()
	pass

func load_game():
	if FileAccess.file_exists(save_file):
		var file = FileAccess.open(save_file, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var data_to_load = data.duplicate()
		save_data.player_party = data_to_load.player_party
		save_data.story_progress = data_to_load.story_progress
		save_data.player_location = data_to_load.player_location
	pass
