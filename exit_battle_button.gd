extends Button
var path

func _ready() -> void:
	pass

func _on_pressed() -> void:
	if path != null:
		var transfer_scene = path.previous_scene
		get_tree().change_scene_to_file(transfer_scene)
	else:
		return
	pass # Replace with function body.
