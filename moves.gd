class_name Move
extends Resource

@export var name: String
@export var type: String
@export var power: int
@export var accuracy: int
@export var energy_cost: int = 10

func can_use(current_energy: int) -> bool:
	return current_energy >= energy_cost


func calculate_damage(attacker, defender) -> int:
	var base_damage = max(1, power + attacker.attack_power - defender.defense_power)
	
	var multiplier = get_type_multiplier(type, defender.type)
	
	return int(base_damage * multiplier)


func get_type_multiplier(move_type: String, defender_type: String) -> float:
	if move_type == "Fire" and defender_type == "Earth":
		return 2.0
	if move_type == "Water" and defender_type == "Fire":
		return 2.0
	if move_type == "Earth" and defender_type == "Water":
		return 2.0
	
	if move_type == defender_type:
		return 0.5
	
	return 1.0
