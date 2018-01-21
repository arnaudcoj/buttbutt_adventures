extends "res://scripts/buttbutt_fsm/buttbutt_classic_state.gd"

onready var stop_state = fsm.get_node("stop")
onready var climb_state = fsm.get_node("idle")

func change_state():
	if fsm.body.test_move(fsm.body.transform, Vector2(0,1)):
		fsm.change_state(stop_state)
	elif fsm.is_control_pressed(Controls.Up) and fsm.body.climb_control.can_climb(): #TODO control jump
		fsm.change_state(climb_state)