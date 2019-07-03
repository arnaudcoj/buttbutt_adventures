extends Node2D

signal pause

var game_over

export (NodePath) var player_path
onready var player = get_node(player_path) if player_path != "" else null

export (NodePath) var in_game_canvas_path
onready var in_game_canvas = get_node(in_game_canvas_path) if in_game_canvas_path != "" else null

func _ready():
	if in_game_canvas != null and player != null:
		in_game_canvas.link_player_to_controls_canvas(player)
		
	if player != null:
		connect("pause", player, "on_pause")
		player.connect("dead", self, "on_game_over")
		player.connect("goal", self, "on_game_over")

func on_game_over():
	game_over = true

func is_game_over():
	return game_over

#func _input(event):
	# reset scene DEBUG
	#if event.is_action_pressed("ui_select"):
	#	game_over = true

func pause():
	get_tree().paused = true
	emit_signal("pause")

func unpause():
	get_tree().paused = false