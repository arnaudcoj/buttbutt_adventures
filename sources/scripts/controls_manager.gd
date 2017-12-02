extends Node

var left_pressed = false
var right_pressed = false

func _ready():
	pass

func is_left_control_pressed():
	return left_pressed or Input.is_action_pressed("left_action")

func is_right_control_pressed():
	return right_pressed or Input.is_action_pressed("right_action")
