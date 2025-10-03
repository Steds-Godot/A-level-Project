extends Button

@onready var player_creature: MyCreature = get_node("../../My_Creature")
@onready var enemy: Enemy = get_node("../../Enemy")

func _ready() -> void:
	
	pass

func _on_pressed() -> void:
	print("Button pressed. player:", player_creature, " enemy:", enemy)

	player_creature.choose_action("attack", enemy)

	if is_instance_valid(enemy):
		if enemy.has_method("choose_action"): 
			enemy.choose_action(player_creature)
		elif enemy.has_method("choose_state") and enemy.has_method("perform_action"):
			enemy.choose_state(player_creature.hp)
			enemy.perform_action(player_creature)
		else:
			print("Warning: enemy has no known turn method.")
