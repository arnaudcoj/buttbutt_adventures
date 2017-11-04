extends "res://scripts/buttbutt_fsm/buttbutt_air_move.gd"

export (NodePath) var sliding_state_path
export (NodePath) var climbing_state_path

func change_state():
	if fsm.body.test_move(fsm.body.transform, Vector2(0,1)):
		fsm.change_state(get_node(sliding_state_path))
	elif fsm.is_control_pressed(fsm.Control.Up) and fsm.body.can_climb(): #TODO control jump
		fsm.change_state(get_node(climbing_state_path))