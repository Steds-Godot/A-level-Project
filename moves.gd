class_name Move

extends Resource

@export var name: String
@export var type: String
@export var power: int
@export var accuracy: int
@export var max_pp: int = 10
var current_pp: int

func _init():
	current_pp = max_pp

func use_move() -> bool:
	if current_pp > 0:
		current_pp -= 1
		return true
	return false

func check_type():
	return type
	pass
