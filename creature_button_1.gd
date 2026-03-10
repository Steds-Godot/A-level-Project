extends Button
@onready var battle_manager: BattleManager = $"../../Battle_Manager"


func _on_pressed() -> void:
	battle_manager.select_creature(0)
	pass # Replace with function body.
