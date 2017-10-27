extends Node2D

func _ready():
	pass

func on_end_area_entered( area ):
	print("the end")


func on_death_area_entered( area ):
	get_tree().reload_current_scene()
