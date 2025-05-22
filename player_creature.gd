extends StaticBody2D


var hp = 20
var level = 1

func ready():
	level = randi_range(1, 5)
	spawn()
	await $MySpriteCreature/AnimationPlayer.animation_finished
	idle()
	
func _process(delta: float) -> void:
	await $MySpriteCreature/AnimationPlayer.animation_finished
	idle()
	
func spawn():
	$MySpriteCreature/AnimationPlayer.play("spawn", -1, 2)
	
func idle():
	$MySpriteCreature/AnimationPlayer.play("idle")


func capture():
	$MySpriteCreature/AnimationPlayer.play("capture")
	await $MySpriteCreature/AnimationPlayer.animation_finished
	pass
