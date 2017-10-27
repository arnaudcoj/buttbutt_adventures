extends Area2D

func _ready():
	connect("area_entered", get_parent(), "on_death_area_entered")