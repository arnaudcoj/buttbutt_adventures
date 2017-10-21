extends Area2D

export (NodePath) var fsm_path
var fsm

func _ready():
	fsm = get_node(fsm_path)

func change_controls(new_left_control, new_right_control):
	fsm.change_controls(new_left_control, new_right_control)