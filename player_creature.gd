extends Node2D
class_name MyCreature

enum PlayerState { ATTACK, DEFEND, HEAL, IDLE }

var level: int = 1
var max_hp: int
var hp: int
var type: String
var attack_power: int
var defense_power: int
var heal_amount: int
var state: int = PlayerState.IDLE
@onready var progress_bar_2: ProgressBar = $"../Enemy/Enemy_HP/ProgressBar2"
@onready var progress_bar: ProgressBar = $"../Player_HP/ProgressBar"
@onready var my_creature: Node2D = $"."

func _init(_name: String = "Player Brudda", _max_hp: int = 100,type: String = "Normal", _attack_power: int = 10, _defense_power: int = 5, _heal_amount: int = 20) -> void:
	name = _name
	max_hp = _max_hp
	hp = _max_hp
	attack_power = _attack_power
	defense_power = _defense_power
	heal_amount = _heal_amount

func _ready() -> void:
	choose_action("idle")

func choose_action(input_action: String, enemy: Node = null) -> void:
	print("PLAYER.choose_action called -> ", input_action, " enemy:", enemy)
	match input_action:
		"attack":
			state = PlayerState.ATTACK
			#$MySpriteCreature/AnimationPlayer.play("attack")
			if enemy:
				var dmg = max(0, attack_power - enemy.defense_power)
				enemy.hp -= dmg
				progress_bar_2.value -= dmg
				print(name, " attacks! Deals ", dmg, " damage.")
		"defend":
			state = PlayerState.DEFEND
			#$MySpriteCreature/AnimationPlayer.play("defend")
			print(name, "used defend")
			defense_power *= 2
		"heal":
			state = PlayerState.HEAL
			#$MySpriteCreature/AnimationPlayer.play("heal")
			var healed = min(max_hp - hp, heal_amount)
			hp += healed
			progress_bar.value += healed
			print(name, " heals for ", healed, " HP!")
		"idle", _:
			state = PlayerState.IDLE
			print(name, " waits...")
