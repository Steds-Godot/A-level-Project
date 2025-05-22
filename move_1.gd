extends Button


func _ready() -> void:
	pass

func _on_pressed() -> void:
	print("attack")
	if $"../../Enemy/Enemy_Creature".hp >= 0:
		$"../../Enemy/Enemy_Creature".on_damage_taken(20)
	else:
		print("OPPONENT HAS FALLEN")
	pass # Replace with function body.
