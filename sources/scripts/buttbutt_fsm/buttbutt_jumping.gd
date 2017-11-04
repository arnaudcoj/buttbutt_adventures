extends "res://scripts/buttbutt_fsm/buttbutt_air_move.gd"

export (NodePath) var idle_state_path
export (NodePath) var falling_state_path

func change_state():
	if not fsm.is_control_pressed(fsm.Control.Jump) or $jump_time.is_stopped(): #TODO control jump
		fsm.change_state(get_node(falling_state_path))
	elif not fsm.is_control_pressed(fsm.Control.Jump) and fsm.body.on_ground():
		fsm.change_state(get_node(idle_state_path))

func on_enter():
	#print("enter jumping")
	.on_enter()
	$jump_time.start()