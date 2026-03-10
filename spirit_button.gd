extends Button
@onready var main_ui: Control = $".."
@onready var spirit_menu: Control = $"../../Spirit_Menu"


func _on_pressed() -> void:
	main_ui.visible = false
	spirit_menu.visible = true
	pass # Replace with function body.
