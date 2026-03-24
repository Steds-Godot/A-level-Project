extends Button


func _on_pressed() -> void:
	DataManager.load_game()
	Player.player_party = DataManager.save_data.player_party
	Player.story_progress = DataManager.save_data.story_progress
	Player.player_location = DataManager.save_data.player_location
	print("Party:", Player.player_party, "Progress: ", Player.story_progress, "Location: ", Player.player_location)
	get_tree().change_scene_to_file(Player.player_location)
	print("Loaded at: ", Player.player_location) 
	pass # Replace with function body.
