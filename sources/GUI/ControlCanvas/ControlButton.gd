extends Control

export var action := "ui_select"

func _on_button_pressed():
	Input.action_press(action)

func _on_button_released():
	Input.action_release(action)
