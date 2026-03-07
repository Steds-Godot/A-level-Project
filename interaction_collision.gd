extends Area2D

@onready var dialogue: Control = $"../Dialogue"
var player: CharacterBody2D = null
var is_talking: bool = false

func _ready() -> void:
	dialogue.visible = false
	pass

func _on_body_entered(body: Node) -> void:
	if is_talking:
		return
	if body is CharacterBody2D:
		is_talking = true
		player = body
		#player.set_can_move(false)
		dialogue.visible = true
		dialogue.position.y = player.position.y - 10
		dialogue.start_or_resume(player)
