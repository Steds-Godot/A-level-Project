extends Area2D

@export var dialogue_node: NodePath
@onready var dialogue = get_node(dialogue_node)
var player: CharacterBody2D
var can_interact := false
var dialogue_running := false
@onready var load_battle_music: AudioStreamPlayer = $"Old-pokemon-battle-music"


func _ready():
	dialogue.dialogue_finished.connect(_on_dialogue_finished)
	dialogue.scale = Vector2(1.5,1.5)

func _on_body_entered(body):
	if body is CharacterBody2D:
		player = body
		can_interact = true


func _on_body_exited(body):
	if body == player:
		player = null
		can_interact = false


func _input(event):
	if !can_interact:
		return
		
	if dialogue_running:
		return

	if event.is_action_pressed("Interact"):
		dialogue_running = true
		#player.set_can_move(false)

		dialogue.start_dialogue(player)
	

func _on_dialogue_finished():
	dialogue_running = false
	if dialogue.type == "Battle":
		load_battle_music.play()
		var t = get_tree().create_timer(3.3)
		await t.timeout
		get_tree().change_scene_to_file("res://battle_grass.tscn")
	if player:
		#player.set_can_move(true)
		pass
