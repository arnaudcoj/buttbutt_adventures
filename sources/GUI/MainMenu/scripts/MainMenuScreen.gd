extends Control

signal leave

func _enter_tree():
	hide()

func open():
	$Timer.start()
	show()

func close():
	hide()
	if !$Timer.is_stopped():
		$Timer.stop()
	
func is_over():
	return Input.is_action_pressed("ui_select") or Input.is_action_pressed("ui_accept")