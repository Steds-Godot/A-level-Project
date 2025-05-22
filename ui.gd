extends Control


func _ready() -> void:
	Player.queue_free()
	$"../AudioStreamPlayer2D".play()
	pass
