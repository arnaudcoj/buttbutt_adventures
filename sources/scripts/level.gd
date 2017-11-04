extends Node2D

func _ready():
	pass
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()

func on_end_area_entered( area ):
	print("the end")
	get_tree().reload_current_scene()


func on_death_area_entered( area ):
	get_tree().reload_current_scene()
