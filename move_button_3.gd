extends Button
@onready var player_creature = $"../../My_Creature"
@onready var enemy = $"../../Enemy"
@onready var battle_manager: BattleManager = $"../../Battle_Manager"
var move: Move

func _on_pressed():
	if battle_manager.current_state != BattleManager.TurnState.PLAYER_TURN:
		return
	
	battle_manager.player_used_move(move)



func set_move(new_move: Move):
	move = new_move
	text = move.name
