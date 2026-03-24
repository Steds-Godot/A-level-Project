extends Node2D
class_name Creature

@export var creature_name: String = "Creature"
@export var type: String = "Normal"
@export var max_hp: int = 100
@export var attack_power: int = 10
@export var defense_power: int = 5
@export var heal_amount: int = 20
@export var moves: Array[Move] = []

var hp: int
var energy: int = 100

func _ready():
	if hp == null or hp <= 0:
		hp = max_hp
	if energy == null or energy <= 0:
		energy = 100

func is_fainted() -> bool:
	return hp <= 0

func use_move(move: Move, target: Creature) -> void:
	if energy < move.energy_cost:
		return
	energy -= move.energy_cost
	var damage = move.calculate_damage(self, target)
	target.hp -= damage
