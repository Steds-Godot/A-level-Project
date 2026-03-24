extends Camera2D
@export var Title_Screen: NodePath
@onready var title_screen = get_node(Title_Screen)


func _ready() -> void:
	position = Player.position
	pass # Replace with function body.


func _process(delta: float) -> void:
	if title_screen.visible == false:
		position = Player.position
		zoom.x = 1.5
		zoom.y = 1.5
	else:
		position.x = 921.0
		position.y = 331.0
		zoom.x = 0.3
		zoom.y = 0.3
	pass
