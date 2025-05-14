extends Control

@export_file("*.json") var file_1
var dialogue = []
var current_dialogue_id = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_dialogue()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_dialogue():
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()
	pass
	
func load_dialogue():
	var file = FileAccess.open("res://dialogue1.json", FileAccess.READ)
	var bulk = JSON.parse_string(file.get_as_text())
	return bulk
	pass
	
func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		return
		
	pass
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]['text']

func _input(event):
	if event.is_action_pressed("Interact"):
		next_script()
