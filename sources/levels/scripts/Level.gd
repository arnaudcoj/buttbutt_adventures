extends Node2D

var game_over 

func on_game_over():
	game_over = true

func is_game_over():
	return game_over

func _input(event):
	# reset scene DEBUG
	if event.is_action_pressed("ui_select"):
		game_over = true