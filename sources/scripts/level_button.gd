extends Button

signal level_selected

export (PackedScene) var level

func _ready():
	connect("pressed", self, "on_click")

func on_click():
	print("jouj")
	emit_signal("level_selected", level)