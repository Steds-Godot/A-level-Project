# BattleManager.gd
extends Node
class_name BattleManager

enum TurnState { PLAYER_TURN, ENEMY_TURN, COOLDOWN }
enum BattleType { TEAM_BATTLE, CAPTURE_BATTLE }

@export var battle_type: BattleType = BattleType.TEAM_BATTLE

var selecting_creature: bool = false
var current_player_index: int = 0
var current_enemy_index: int = 0
var current_state: TurnState = TurnState.PLAYER_TURN
var player_team: Array = []
var enemy_team: Array = []

@onready var player_squad: Node = $"../Player_Team"
@onready var enemy_squad: Node = $"../Enemy_Team"
@onready var player_hp_bar: ProgressBar = $"../Player_HP/ProgressBar"
@onready var player_energy_bar: ProgressBar = $"../Player_Energy/ProgressBar"
@onready var enemy_hp_bar: ProgressBar = $"../Enemy_HP/ProgressBar2"
@onready var enemy_energy_bar: ProgressBar = $"../Enemy_Energy/ProgressBar"
@onready var move_buttons = [
	$"../Attack_Menu/Move_Button",
	$"../Attack_Menu/Move_Button2",
	$"../Attack_Menu/Move_Button3",
	$"../Attack_Menu/Move_Button4"
]
@onready var main_ui: Control = $"../MainUI"
@onready var dialogue_text: RichTextLabel = $"../NinePatchRect/Text"
@onready var attack_menu: Control = $"../Attack_Menu"
@onready var spirit_menu: Control = $"../Spirit_Menu"
@onready var selection_buttons = [
	$"../Spirit_Menu/Creature_Button1",
	$"../Spirit_Menu/Creature_Button2",
	$"../Spirit_Menu/Creature_Button3"
]
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var fire_move_sounds: AudioStreamPlayer2D = $"../Fire_Move_Sounds"
@onready var air_move_sounds: AudioStreamPlayer2D = $"../Air_Move_Sounds"
@onready var earth_move_sounds: AudioStreamPlayer2D = $"../Earth_Move_Sounds"
@onready var water_move_sounds: AudioStreamPlayer2D = $"../Water_Move_Sounds"
@onready var exit_battle_button: Button = $"../NinePatchRect/Exit_Battle_Button"
@onready var retreat_battle_button: Button = $"../NinePatchRect/Retreat_Battle_Button"

func _ready():
	Player.queue_free()
	audio_stream_player_2d.play()
	player_team.clear()
	for creature in player_squad.get_children():
		if creature is PlayerCreature:
			player_team.append(creature)

	enemy_team.clear()
	for enemy in enemy_squad.get_children():
		if enemy is EnemyCreature:
			enemy_team.append(enemy)
			enemy.generate_moves()

	start_battle()

func active_player_creature():
	return player_team[current_player_index]

func active_enemy_creature():
	return enemy_team[current_enemy_index]

func is_battle_over() -> bool:
	return player_team.all(func(c): return c.is_fainted()) or enemy_team.all(func(c): return c.is_fainted())


func start_battle():
	current_player_index = 0
	current_enemy_index = 0

	for enemy in enemy_team:
		if enemy is EnemyCreature:
			enemy.generate_moves()

	for c in player_team:
		c.hp = c.max_hp
		c.energy = 100
	for e in enemy_team:
		e.hp = e.max_hp
		e.energy = 100

	update_bars()
	start_player_turn()
func update_bars():
	var player = active_player_creature()
	var enemy = active_enemy_creature()

	player_hp_bar.max_value = player.max_hp
	player_hp_bar.value = player.hp
	player_energy_bar.max_value = 100
	player_energy_bar.value = player.energy

	enemy_hp_bar.max_value = enemy.max_hp
	enemy_hp_bar.value = enemy.hp
	enemy_energy_bar.max_value = 100
	enemy_energy_bar.value = enemy.energy


func prompt_player_selection():
	selecting_creature = true
	main_ui.visible = false
	spirit_menu.visible = true
	set_buttons_enabled(false)
	for i in range(selection_buttons.size()):
		if i < player_team.size():
			var c = player_team[i]
			main_ui.visible = false
			attack_menu.visible = false
			selection_buttons[i].visible = true
			selection_buttons[i].disabled = false
			selection_buttons[i].text = c.creature_name
			if c.is_fainted():
				selection_buttons[i].disabled = true
				pass
		else:
			selection_buttons[i].visible = false

		dialogue_text.text = "Choose your creature!"
	

func select_creature(index: int):
	print("Creature selected:", index)
	current_player_index = index
	selecting_creature = false
	spirit_menu.visible = false
	main_ui.visible = true

	dialogue_text.text = "You chose " + active_player_creature().creature_name
	update_bars()
	var timer = get_tree().create_timer(1.5)
	await timer.timeout
	start_player_turn()

func start_player_turn():
	current_state = TurnState.PLAYER_TURN
	setup_buttons()
	set_buttons_enabled(true)
	dialogue_text.text = active_player_creature().creature_name + "'s turn!"



# Player uses a move
func player_used_move(move: Move) -> void:
	if current_state != TurnState.PLAYER_TURN:
		return

	var player = active_player_creature()
	var enemy = active_enemy_creature()

	# Use the move
	player.use_move(move, enemy)
	
	var damage = move.calculate_damage(player, enemy)
	dialogue_text.text = "%s used %s and dealt %d damage!" % [player.creature_name, move.name, damage]
	update_bars()
	
	if move.type == "Fire":
		fire_move_sounds.play(1)
		var timer = get_tree().create_timer(1.5)
		await timer.timeout 
		fire_move_sounds.stop()
	elif move.type == "Water":
		water_move_sounds.play()
		var timer = get_tree().create_timer(1.5)
		await timer.timeout 
		water_move_sounds.stop()
		pass
	elif move.type == "Earth":
		earth_move_sounds.play()
		var timer = get_tree().create_timer(1.5)
		await timer.timeout 
		earth_move_sounds.stop()
		pass
	else:
		air_move_sounds.play(1)
		var timer = get_tree().create_timer(1.5)
		await timer.timeout 
		air_move_sounds.stop()
		pass
	# Update the centralized UI
	

	# Show dialogue with damage

	# Disable move buttons
	set_buttons_enabled(false)

	# Wait 1.5 seconds before enemy turn
	var timer = get_tree().create_timer(1.5)
	await timer.timeout

	# Check for any faints
	check_faints()

	# If battle continues, start enemy turn
	if not is_battle_over():
		start_enemy_turn()


# Enemy turn
func start_enemy_turn() -> void:
	current_state = TurnState.ENEMY_TURN
	set_buttons_enabled(false)

	var enemy = active_enemy_creature()
	var player = active_player_creature()

	if enemy is EnemyCreature:
		var move = enemy.perform_random_move(player) # damage applied inside
		

		var damage = move.calculate_damage(enemy, player)
		update_bars()
		dialogue_text.text = "%s used %s and dealt %d damage!" % [enemy.creature_name, move.name, damage]
		if move.type == "Fire":
			fire_move_sounds.play(1)
			var timer = get_tree().create_timer(1.5)
			await timer.timeout 
			fire_move_sounds.stop()
		elif move.type == "Water":
			water_move_sounds.play()
			var timer = get_tree().create_timer(1.5)
			await timer.timeout 
			water_move_sounds.stop()
			pass
		elif move.type == "Earth":
			earth_move_sounds.play()
			var timer = get_tree().create_timer(1.5)
			await timer.timeout 
			earth_move_sounds.stop()
			pass
		else:
			air_move_sounds.play(1)
			var timer = get_tree().create_timer(1.5)
			await timer.timeout 
			air_move_sounds.stop()
			pass
		

	# Wait 1.5 seconds before next player turn
	var timer = get_tree().create_timer(1.5)
	await timer.timeout 

	check_faints()

	if not is_battle_over():
		start_player_turn()

	# If battle is not over, start player turn
	if not is_battle_over():
		start_player_turn()

func setup_buttons():
	var player = active_player_creature()
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
	if active_player_creature().is_fainted():
		if player_team.any(func(c): return not c.is_fainted()):
			dialogue_text.text = active_player_creature().creature_name + "s fainted! Choose a new creature."
			var timer = get_tree().create_timer(1.5)
			await timer.timeout
			prompt_player_selection()
		else:
			dialogue_text.text = "All your creatures fainted! Game Over!"
			var timer = get_tree().create_timer(3)
			await timer.timeout
			main_ui.visible = false
			attack_menu.visible = false
			spirit_menu.visible = false
			retreat_battle_button.visible = true
	if active_enemy_creature().is_fainted():
		current_enemy_index += 1
		if current_enemy_index >= enemy_team.size():
			dialogue_text.text = "You won the battle!"
			var timer = get_tree().create_timer(3)
			await timer.timeout
			main_ui.visible = false
			attack_menu.visible = false
			spirit_menu.visible = false
			exit_battle_button.visible = true
		else:
			dialogue_text.text = "Enemy sends out %s!" % active_enemy_creature().creature_name
			var timer = get_tree().create_timer(1.5)
			await timer.timeout


func show_dialogue(text):
	dialogue_text.text = text

func player_rested():
	player_energy_bar.value += 50
	show_dialogue("Player Has Rested")
	var timer = get_tree().create_timer(1.5)
	await timer.timeout
	start_enemy_turn()
