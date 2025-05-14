extends Area2D
@onready var player_spawner: Node2D = $"."
@onready var player: CharacterBody2D = $"/root/Player"




@export var packed_scene : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



	
	
	pass # Replace with function body.


func _on_body_entered(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_packed(packed_scene)
	pass # Replace with function body.
