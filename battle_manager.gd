# BattleManager.gd
extends Node
class_name BattleManager

enum TurnState { PLAYER_TURN, ENEMY_TURN, COOLDOWN }
enum BattleType { TEAM_BATTLE, CAPTURE_BATTLE }

@export var battle_type: BattleType = BattleType.TEAM_BATTLE


var player_team: Array = []
var enemy_team: Array = []

var current_player_idx := 0
var current_enemy_idx := 0
var current_state: TurnState = TurnState.PLAYER_TURN

@onready var move_buttons = [
	$"../Attack_Menu/Move_Button",
	$"../Attack_Menu/Move_Button2",
	$"../Attack_Menu/Move_Button3",
	$"../Attack_Menu/Move_Button4"
]

@onready var dialogue_text: RichTextLabel = $"../NinePatchRect/Text"
@onready var selection_buttons = [
	$"../PlayerSelectionContainer/CreatureButton1",
	$"../PlayerSelectionContainer/CreatureButton2",
	$"../PlayerSelectionContainer/CreatureButton3"
]

var selecting_creature: bool = false


func get_active_player():
	return player_team[current_player_idx]

func get_active_enemy():
	return enemy_team[current_enemy_idx]

func is_battle_over() -> bool:
	return player_team.all(func(c): return c.is_fainted()) or enemy_team.all(func(c): return c.is_fainted())


func start_battle():
	current_player_idx = 0
	current_enemy_idx = 0

	for enemy in enemy_team:
		if enemy is EnemyCreature:
			enemy.generate_moves()

	prompt_player_selection()


func prompt_player_selection():
	selecting_creature = true

	for i in range(selection_buttons.size()):
		if i < player_team.size():
			var c = player_team[i]
			selection_buttons[i].visible = true
			selection_buttons[i].disabled = c.is_fainted()
			selection_buttons[i].text = c.creature_name
		else:
			selection_buttons[i].visible = false

	dialogue_text.text = "Choose your creature!"
	set_buttons_enabled(false)

func select_creature(index: int):
	current_player_idx = index
	selecting_creature = false

	for btn in selection_buttons:
		btn.visible = false

	dialogue_text.text = "You chose " + get_active_player().creature_name
	start_player_turn()


func start_player_turn():
	current_state = TurnState.PLAYER_TURN
	setup_buttons()
	dialogue_text.text =  get_active_player().creature_name + "s's turn!"

func player_used_move(move: Move):
	if current_state != TurnState.PLAYER_TURN or get_active_player().is_fainted():
		return

	var player = get_active_player()
	var enemy = get_active_enemy()

	player.use_move(move, enemy)
	set_buttons_enabled(false)

	await get_tree().create_timer(1.5).timeout
	check_faints()
	if not is_battle_over():
		start_enemy_turn()

func start_enemy_turn():
	current_state = TurnState.ENEMY_TURN
	set_buttons_enabled(false)

	var enemy = get_active_enemy()
	var player = get_active_player()
	if enemy is EnemyCreature:
		enemy.perform_random_move(player)

	await get_tree().create_timer(1.5).timeout
	check_faints()
	if not is_battle_over():
		start_player_turn()

func setup_buttons():
	var player = get_active_player()
	for i in move_buttons.size():
		if i < player.moves.size():
			move_buttons[i].set_move(player.moves[i])
			move_buttons[i].disabled = false
		else:
			move_buttons[i].disabled = true

func set_buttons_enabled(value: bool):
	for button in move_buttons:
		button.disabled = not value

func check_faints():
	if get_active_player().is_fainted():
		if player_team.any(func(c): return not c.is_fainted()):
			dialogue_text.text = get_active_player().creature_name + "s fainted! Choose a new creature."
			prompt_player_selection()
		else:
			dialogue_text.text = "All your creatures fainted! Game Over!"

	if get_active_enemy().is_fainted():
		current_enemy_idx += 1
		if current_enemy_idx >= enemy_team.size():
			dialogue_text.text = "You won the battle!"
		else:
			dialogue_text.text = "Enemy sends out %s!" % get_active_enemy().creature_name
