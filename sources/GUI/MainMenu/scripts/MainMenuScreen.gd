extends Control

signal leave

var over

func _enter_tree():
	hide()

func open():
	over = false
	$Timer.start()
	show()

func close():
	hide()
	if !$Timer.is_stopped():
		$Timer.stop()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		over = true
	
func is_over():
	return Input.is_action_pressed("ui_accept") or over