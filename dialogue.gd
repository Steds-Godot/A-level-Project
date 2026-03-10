extends Control

signal dialogue_finished

@export_file("*.json") var dialogue_file
@export var text_speed := 0.03
@export var fade_duration := 0.5
@export var type:= "normal"

@onready var name_label = $NinePatchRect/Name
@onready var text_label = $NinePatchRect/Text
@onready var box = $NinePatchRect


var dialogue = []
var current_line := 0
var typing := false
var full_text := ""

func _ready():
	visible = false
	dialogue = load_dialogue()
	box.modulate.a = 0.0


func load_dialogue():
	var file = FileAccess.open(dialogue_file, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())


func start_dialogue(player):
	current_line = 0
	visible = true

	# fade in
	var tween = create_tween()
	tween.tween_property(box, "modulate:a", 1.0, fade_duration)

	show_line()


func show_line():
	var line = dialogue[current_line]

	name_label.text = line["name"]
	full_text = line["text"]
	text_label.text = ""

	type_text()


func type_text():
	typing = true

	for c in full_text:
		text_label.text += c
		await get_tree().create_timer(text_speed).timeout

	typing = false


func next_line():
	if typing:
		text_label.text = full_text
		typing = false
		return

	current_line += 1

	if current_line >= dialogue.size():
		end_dialogue()
	else:
		show_line()


func end_dialogue():
	var tween = create_tween()
	tween.tween_property(box, "modulate:a", 0.0, fade_duration)

	await tween.finished

	visible = false
	dialogue_finished.emit()


func _input(event):
	if !visible:
		return

	if event.is_action_pressed("Interact"):
		next_line()
