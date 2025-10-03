extends Area2D
@onready var player_spawner: Node2D = $"."
@onready var player: CharacterBody2D = $"/root/Player"




@export var packed_scene : PackedScene

func _ready() -> void:
	pass



func _process(delta: float) -> void:
	pass



	
	
	pass


func _on_body_entered(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_packed(packed_scene)
	pass
