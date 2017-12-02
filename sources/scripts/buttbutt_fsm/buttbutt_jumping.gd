extends "res://scripts/buttbutt_fsm/buttbutt_air_move.gd"

export (NodePath) var idle_state_path
export (NodePath) var falling_state_path

func change_state():
	if not fsm.is_control_pressed(fsm.Control.Jump) or $jump_time.is_stopped(): #TODO control jump
		fsm.change_state(get_node(falling_state_path))

func on_enter():
	.on_enter()
	fsm.body.enable_capsule_collision()
	$jump_time.start()
	
func on_leave():
	fsm.body.enable_rectangular_collision()