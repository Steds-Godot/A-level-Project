extends Control
class_name Title_Screen

func _ready() -> void:
	Player.visible = false

func show_title():
	
	visible = true
	print("Title screen shown")

func hide_title():
	visible = false
	print("Title screen hidden")
