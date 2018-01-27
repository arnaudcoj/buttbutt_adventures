extends Control

signal start_pressed

func _ready():
	controls_manager.enabled = false
	pass

func _input(event):
	if event.is_action_pressed("left_action") or event.is_action_pressed("right_action"):
		_on_start_pressed()

func _on_start_pressed():
	emit_signal("start_pressed")
	controls_manager.enabled = true
	hide()
