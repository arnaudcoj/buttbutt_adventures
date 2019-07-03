extends Control

signal pause

var control_canvas

func _on_PauseButton_pressed():
	emit_signal("pause")

func _enter_tree():
	control_canvas = get_node("ControlCanvas")
	