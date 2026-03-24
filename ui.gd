extends Node2D
@export var Title_Screen: NodePath
@onready var title_screen = get_node(Title_Screen)
@onready var camera: Camera2D = $Camera
@export var Tile_Map: NodePath
@onready var tile_map = get_node(Tile_Map)


func _ready() -> void:
	title_screen.hide_title()
	Player.visible = true
	pass

func _process(delta: float) -> void:
	pass

func _unhandled_input(event):
	if event.is_action_pressed("Menu"):
		print("Pressed Menu. Visible:", title_screen.visible)

		if title_screen.visible:
			title_screen.hide_title()
			Player.visible = true
			tile_map.visible = true
		else:
			title_screen.show_title()
			Player.visible = false
			tile_map.visible = false
