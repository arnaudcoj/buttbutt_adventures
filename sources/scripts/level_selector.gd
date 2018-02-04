extends Control

signal level_selected

func _ready():
	pass

func on_level_selected(level):
	emit_signal("level_selected", level)
