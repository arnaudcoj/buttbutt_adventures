extends FSMState

export (NodePath) var in_game_canvas_path
onready var in_game_canvas : Control = get_node(in_game_canvas_path)

export (NodePath) var level_path
onready var level = get_node(level_path)

enum { NONE, QUIT, RESUME }
var action_wanted

func get_next_state():
	if action_wanted == QUIT:
		return $"../Quit"
	elif action_wanted == RESUME:
		return $"../Game"

func leave_state():
	in_game_canvas.pause_screen.disconnect("resume", self, "_on_resume_pressed")
	in_game_canvas.pause_screen.disconnect("quit", self, "_on_quit_pressed")
	action_wanted = NONE
	level.unpause()

func enter_state():
	print("enter ", name)
	in_game_canvas.pause_screen.show()
	in_game_canvas.hud_screen.hide()
	in_game_canvas.pause_screen.connect("resume", self, "_on_resume_pressed")
	in_game_canvas.pause_screen.connect("quit", self, "_on_quit_pressed")
	level.pause()

func _enter_tree():
	in_game_canvas = get_node(in_game_canvas_path)
	in_game_canvas.pause_screen.hide()
	in_game_canvas.hud_screen.show()
	action_wanted = NONE
	
func _on_resume_pressed():
	action_wanted = RESUME
	
func _on_quit_pressed():
	action_wanted = QUIT