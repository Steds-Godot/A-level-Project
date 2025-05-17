extends Area2D

var dialogue_scene = preload("res://dialogue.tscn")
var dialogue = dialogue_scene.instantiate()
var is_talking = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: CharacterBody2D) -> void:
	add_child(dialogue)
	dialogue.position.y = Player.position.y -10
	print("interaction")
	is_talking = true
	pass # Replace with function body.


func _on_body_exited(body: CharacterBody2D) -> void:
	remove_child(dialogue)
	is_talking = false
	pass # Replace with function body.
