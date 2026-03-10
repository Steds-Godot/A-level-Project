extends Button

@onready var battle_manager: BattleManager = $"../../Battle_Manager"


var move: Move

func _pressed():
	if battle_manager.current_state != BattleManager.TurnState.PLAYER_TURN:
		return
	
	if move == null:
		print("Move missing!")
		return

	print("Player used:", move.name)

	battle_manager.player_used_move(move)


func set_move(new_move: Move):
	move = new_move
	text = move.name
