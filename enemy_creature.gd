extends Node2D
class_name Enemy

enum EnemyState { HEAL, FLEE, ATTACK, DEFEND, CAPTURE, IDLE }

var level: int = 1
var max_hp: int = level * 100
var hp: int
var type: String
var attack_power: int
var defense_power: int
var heal_amount: int
var state: int = EnemyState.IDLE
var is_captured: bool = false
var heal_items: int
@onready var progress_bar_2: ProgressBar = $Enemy_HP/ProgressBar2
@onready var enemy: Node2D = $"."
@onready var progress_bar: ProgressBar = $"../My_Creature/Player_HP/ProgressBar"

func _init(_name: String = "Enemy Brudda", _max_hp: int = 100,type: String = "Normal", _attack_power: int = 8, _defense_power: int = 3, _heal_amount: int = 15, _heal_items: int = 1) -> void:
	name = _name
	max_hp = _max_hp
	hp = _max_hp
	attack_power = _attack_power
	defense_power = _defense_power
	heal_amount = _heal_amount
	heal_items = _heal_items

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func spawn() -> void:
	$EnemySpriteCreature/AnimationPlayer.play("spawn", -1, 2)

func capture() -> void:
	$EnemySpriteCreature/AnimationPlayer.play("capture")
	await $EnemySpriteCreature/AnimationPlayer.animation_finished

func choose_state(player_hp: int) -> void:
	if hp <= max_hp * 0.2:
		if randf() < 0.5:
			state = EnemyState.HEAL
		else:
			state = EnemyState.FLEE
	elif player_hp <= attack_power * 1.5:
		state = EnemyState.ATTACK
	else:
		state = EnemyState.ATTACK
		
func perform_action(player) -> void:
	match state:
		EnemyState.ATTACK:
			var dmg = max(0, attack_power - player.defense_power)
			player.hp -= dmg
			progress_bar.value -= dmg
			print(name, " attacks! Deals ", dmg, " damage.")
		EnemyState.DEFEND:
			print(name, " defends, reducing damage next turn.")
			defense_power *= 2
		EnemyState.HEAL:
			var healed = min(max_hp - hp, heal_amount)
			hp += healed
			progress_bar_2.value += healed
			print(name, " heals for ", healed, " HP!")
		EnemyState.FLEE:
			print(name, " tries to flee the battle!")
		EnemyState.IDLE:
			print(name, " waits...")
