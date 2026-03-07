# PlayerCreature.gd
extends Creature
class_name PlayerCreature

# Use a move on a target creature
func use_move(move: Move, target: Creature):
	if energy < move.energy_cost:
		if text:
			text.text = "Not enough energy!"
		return
	
	energy -= move.energy_cost
	if energy_bar:
		energy_bar.value = energy

	var damage = move.calculate_damage(self, target)
	target.hp -= damage
	if target.progress_bar:
		target.progress_bar.value = target.hp

	if text:
		text.text = "%s used %s and dealt %d damage!" % [creature_name, move.name, damage]
