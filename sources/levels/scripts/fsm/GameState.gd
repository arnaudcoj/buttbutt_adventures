extends FSMState

export (NodePath) var pause_button_path
onready var pause_button : Button = get_node(pause_button_path)

export (NodePath) var pause_screen_path
onready var pause_screen = get_node(pause_screen_path)

export (NodePath) var hud_screen_path
onready var hud_screen : Control = get_node(hud_screen_path)

var pause_requested

func _on_PauseButton_pressed():
	pause_requested = true

func get_next_state():
	if pause_requested:
		return $"../Pause"
	return null

func enter_state():
	print("enter ", name)
	pause_button.connect("pressed", self, "_on_PauseButton_pressed")
	pause_screen.hide()
	hud_screen.show()

func leave_state():
	pause_requested = false
	pause_button.disconnect("pressed", self, "_on_PauseButton_pressed")

func _enter_tree():
	pause_requested = false