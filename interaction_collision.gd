extends Area2D
var interaction = self
var parent_node = interaction.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: CharacterBody2D) -> void:
	dialogue()
	pass # Replace with function body.

func dialogue():
	print("dialogue")
	pass
	
func battle_start():
	pass
