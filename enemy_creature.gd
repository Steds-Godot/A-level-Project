extends StaticBody2D

var level = 1
const max_hp : int = 100
var hp : int = 100
@onready var progress_bar_2: ProgressBar = $"../Enemy_HP/ProgressBar2"


func ready():
	level = randi_range(1, 5)
	spawn()
	await $MySpriteCreature/AnimationPlayer.animation_finished
	idle()
	hp = max_hp
	progress_bar_2.value = hp
	pass
	
func on_damage_taken(damage):
	hp -= damage
	print(hp)
	$EnemySpriteCreature/AnimationPlayer.play("hurt")
	progress_bar_2.value = hp
	if hp <= 0:
		queue_free()
		
	
func _process(delta: float) -> void:
	await $EnemySpriteCreature/AnimationPlayer.animation_finished
	idle()
	
func spawn():
	$EnemySpriteCreature/AnimationPlayer.play("spawn", -1, 2)
	
func idle():
	$EnemySpriteCreature/AnimationPlayer.play("idle")


func capture():
	$EnemySpriteCreature/AnimationPlayer.play("capture")
	await $EnemySpriteCreature/AnimationPlayer.animation_finished
	pass
