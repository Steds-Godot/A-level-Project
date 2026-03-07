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

# Optional UI references
@onready var progress_bar: ProgressBar
@onready var energy_bar: ProgressBar
@onready var text: RichTextLabel

func _ready():
	hp = max_hp
	if progress_bar:
		progress_bar.value = hp
	if energy_bar:
		energy_bar.value = energy

func is_fainted() -> bool:
	return hp <= 0
