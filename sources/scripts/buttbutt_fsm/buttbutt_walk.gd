extends "res://scripts/buttbutt_fsm/buttbutt_classic_state.gd"

onready var running_state = fsm.get_node("run")
onready var stopping_state = fsm.get_node("stop")
onready var falling_state = fsm.get_node("fall")
onready var climbing_state = fsm.get_node("climb")
onready var jumping_state = fsm.get_node("jump")

func change_state():
	if not fsm.body.on_ground():
		fsm.change_state(falling_state)
	elif fsm.is_control_pressed(Controls.Jump):
		fsm.change_state(jumping_state)
	if fsm.is_control_pressed(Controls.Up) and fsm.body.climb_control.can_climb(): #TODO Jump
			fsm.change_state(climbing_state)
	elif (not fsm.is_control_pressed(Controls.Left) and not fsm.is_control_pressed(Controls.Right)) or (fsm.is_control_pressed(Controls.Left) and fsm.is_control_pressed(Controls.Right)):
		fsm.change_state(stopping_state)
	elif fsm.is_control_pressed(Controls.RunLeft) or fsm.is_control_pressed(Controls.RunRight):
		fsm.change_state(running_state)

func is_moving_right():
	return fsm.is_control_pressed(Controls.Right)
	
func is_moving_left():
	return fsm.is_control_pressed(Controls.Left)