extends Control

signal quit
signal resume

func _on_QuitButton_pressed():
	emit_signal("quit")

func _on_ResumeButton_pressed():
	emit_signal("resume")
