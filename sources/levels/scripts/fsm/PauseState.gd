extends FSMState

export (NodePath) var level_path
onready var level = get_node(level_path)

export (NodePath) var pause_screen_path
onready var pause_screen = get_node(pause_screen_path)

export (NodePath) var hud_screen_path
onready var hud_screen : Control = get_node(hud_screen_path)

export (NodePath) var quit_button_path
onready var quit_button : Button = get_node(quit_button_path)

export (NodePath) var resume_button_path
onready var resume_button : Button = get_node(resume_button_path)

enum { NONE, QUIT, RESUME }
var action_wanted

func get_next_state():
	if action_wanted == QUIT:
		return $"../Quit"
	elif action_wanted == RESUME:
		return $"../Game"

func leave_state():
	resume_button.disconnect("pressed", self, "_on_resume_pressed")
	quit_button.disconnect("pressed", self, "_on_quit_pressed")
	action_wanted = NONE
	level.unpause()

func enter_state():
	print("enter ", name)
	pause_screen.show()
	hud_screen.hide()
	resume_button.connect("pressed", self, "_on_resume_pressed")
	quit_button.connect("pressed", self, "_on_quit_pressed")
	level.pause()

func _enter_tree():
	get_node(pause_screen_path).hide()
	get_node(hud_screen_path).show()
	action_wanted = NONE
	
func _on_resume_pressed():
	action_wanted = RESUME
	
func _on_quit_pressed():
	action_wanted = QUIT