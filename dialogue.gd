extends Control

@export_file("*.json") var file_1
var dialogue = []
var current_dialogue_id = -1
var dialogue_finished = false
var player: CharacterBody2D = null
var fade_duration = 0.5

func _ready():
	dialogue = load_dialogue()
	$NinePatchRect.modulate.a = 0.0
	visible = false

func load_dialogue():
	var file = FileAccess.open("res://dialogue1.json", FileAccess.READ)
	var bulk = JSON.parse_string(file.get_as_text())
	return bulk

func start_or_resume(player_ref: CharacterBody2D):
	player = player_ref
	current_dialogue_id = -1
	next_script()
	fade_in()

func next_script():
	if dialogue_finished:
		fade_out()
		return

	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		dialogue_finished = true
		current_dialogue_id = len(dialogue) - 1

	show_current_line()

func show_current_line():
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]["name"]
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]["text"]
	visible = true
	$NinePatchRect.modulate.a = 1.0

func fade_in():
	visible = true
	$NinePatchRect.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property($NinePatchRect, "modulate:a", 1.0, fade_duration)

func fade_out():
	var tween = create_tween()
	tween.tween_property($NinePatchRect, "modulate:a", 0.0, fade_duration)
	tween.finished.connect(_on_fade_finished)

func _on_fade_finished():
	visible = false
	#if player:
		#player.set_can_move(true)

func _input(event):
	if event.is_action_pressed("Interact"):
		next_script()
