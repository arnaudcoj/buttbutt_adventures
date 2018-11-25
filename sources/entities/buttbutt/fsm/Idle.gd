extends "res://entities/buttbutt/fsm/fsm_state.gd"

func get_next_state():
	if Input.is_action_just_pressed("ui_up"):
		return $"../Jump"
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		return $"../Walk"
	if not body.is_on_floor():
		return $"../Fall"