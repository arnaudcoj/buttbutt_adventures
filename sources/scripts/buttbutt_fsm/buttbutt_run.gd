extends "res://scripts/buttbutt_fsm/buttbutt_ground_move.gd"

export (NodePath) var walking_state_path

func update(delta):
	.update(delta)
	
func change_state():
	if not fsm.body.on_ground():
		fsm.change_state(get_node(falling_state_path))
	elif fsm.is_control_pressed(fsm.Control.Jump):
		fsm.change_state(get_node(jumping_state_path))
	elif fsm.is_control_pressed(fsm.Control.Up) and fsm.body.can_climb(): #TODO Jump
		fsm.change_state(get_node(climbing_state_path))
	elif not fsm.is_control_pressed(fsm.Control.RunLeft) and not fsm.is_control_pressed(fsm.Control.RunRight):
		fsm.change_state(get_node(idle_state_path))
	elif fsm.is_control_pressed(fsm.Control.Left) or fsm.is_control_pressed(fsm.Control.Right):
		fsm.change_state(get_node(walking_state_path))

func is_moving_right():
	return fsm.is_control_pressed(fsm.Control.RunRight)
	
func is_moving_left():
	return fsm.is_control_pressed(fsm.Control.RunLeft)
