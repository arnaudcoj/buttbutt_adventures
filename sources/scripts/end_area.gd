extends Area2D

func _ready():
	connect("area_entered", get_parent(), "on_end_area_entered")