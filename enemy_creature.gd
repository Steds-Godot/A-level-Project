extends Creature
class_name EnemyCreature

@export var max_enemy_moves: int = 4

# Randomly pick moves for this enemy
func generate_moves():
	if moves.size() == 0:
		return
	moves.shuffle()
	if moves.size() > max_enemy_moves:
		moves = moves.slice(0, max_enemy_moves)

# Perform a random move on target creature
func perform_random_move(target: Creature) -> Move:
	if moves.size() == 0:
		return null
	var move = moves.pick_random()
	use_move(move, target)
	return move
func use_move(move: Move, target: Creature) -> void:
	if energy < move.energy_cost:
		return

	energy -= move.energy_cost

	var damage = move.calculate_damage(self, target)
	target.hp -= damage
