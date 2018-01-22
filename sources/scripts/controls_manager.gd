extends Node

var enabled = true

var left_pressed = false
var right_pressed = false

func _ready():
	pass

func is_left_control_pressed():
	return enabled and (left_pressed or Input.is_action_pressed("left_action"))

func is_right_control_pressed():
	return enabled and (right_pressed or Input.is_action_pressed("right_action"))
