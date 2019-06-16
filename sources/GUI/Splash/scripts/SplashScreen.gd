extends Control

signal leave

func _enter_tree():
	hide()

func open():
	$Timer.start()
	show()

func close():
	if !$Timer.is_stopped():
		$Timer.stop()
	hide()
	
func is_over():
	return $Timer.is_stopped()