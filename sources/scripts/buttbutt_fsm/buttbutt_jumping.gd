extends "res://scripts/buttbutt_fsm/buttbutt_classic_state.gd"

onready var idle_state = fsm.get_node("idle")
onready var fall_state = fsm.get_node("fall")

func change_state():
	if not fsm.is_control_pressed(Controls.Jump) or fsm.velocity.y >= 0: #TODO control jump
		fsm.change_state(fall_state)
