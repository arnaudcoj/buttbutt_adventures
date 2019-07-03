extends FSMState

export (NodePath) var in_game_canvas_path
onready var in_game_canvas : Control = get_node(in_game_canvas_path)

var pause_requested

func _on_PauseButton_pressed():
	pause_requested = true

func get_next_state():
	if pause_requested:
		return $"../Pause"
	return null

func enter_state():
	print("enter ", name)
	in_game_canvas.hud_screen.connect("pause", self, "_on_PauseButton_pressed")
	in_game_canvas.pause_screen.hide()
	in_game_canvas.hud_screen.show()

func leave_state():
	pause_requested = false
	in_game_canvas.hud_screen.disconnect("pause", self, "_on_PauseButton_pressed")

func _enter_tree():
	pause_requested = false