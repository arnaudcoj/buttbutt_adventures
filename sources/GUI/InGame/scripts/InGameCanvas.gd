extends Control

var hud_screen
var pause_screen

func _enter_tree():
	hud_screen = get_node("HUD")
	pause_screen = get_node("PauseScreen")

func link_player_to_controls_canvas(player):
	hud_screen.control_canvas.link_player(player)