extends Area2D

@export var dialogue_scene: PackedScene = load("res://Dialogue.tscn")
var dialogue: Control = null
var player: CharacterBody2D = null
var is_talking: bool = false

func _on_body_entered(body: Node) -> void:
	if is_talking:
		return
	if body is CharacterBody2D:
		is_talking = true
		player = body
		#player.set_can_move(false)
		
		dialogue = dialogue_scene.instantiate() as Control
		add_child(dialogue)
		dialogue.position.y = player.position.y - 10
		dialogue.start_or_resume(player)
