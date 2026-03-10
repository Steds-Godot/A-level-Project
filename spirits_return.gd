extends Button

@onready var main_ui: Control = $"../../MainUI"
@onready var spirit_menu: Control = $".."

func _on_pressed() -> void:
	main_ui.visible = true
	spirit_menu.visible = false
	pass # Replace with function body.
