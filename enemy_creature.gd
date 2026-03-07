# EnemyCreature.gd
extends Creature
class_name EnemyCreature

@export var max_enemy_moves: int = 4

# Pick random moves from the creature's move pool
func generate_moves():
	moves.shuffle()
	if moves.size() > max_enemy_moves:
		moves = moves.slice(0, max_enemy_moves)

# Perform a random move on a target creature
func perform_random_move(target: Creature):
	if moves.size() == 0:
		return

	var move = moves.pick_random()
	var damage = move.calculate_damage(self, target)
	target.hp -= damage

	if target.progress_bar:
		target.progress_bar.value = target.hp

	if text:
		text.text = "%s used %s and dealt %d damage!" % [creature_name, move.name, damage]
