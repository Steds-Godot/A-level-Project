extends Button

func _on_pressed() -> void:
	DataManager.save_data.player_party = Player.player_party
	DataManager.save_data.story_progress = Player.story_progress
	DataManager.save_data.player_location = Player.player_location
	DataManager.save_game()
	pass # Replace with function body.
