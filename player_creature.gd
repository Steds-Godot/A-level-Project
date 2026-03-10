extends Creature
class_name PlayerCreature

# Use a move on a target creature
func use_move(move: Move, target: Creature) -> void:
	if energy < move.energy_cost:
		return

	# Subtract energy
	energy -= move.energy_cost

	# Calculate damage
	var damage = move.calculate_damage(self, target)

	# Subtract HP from target
	target.hp -= damage
