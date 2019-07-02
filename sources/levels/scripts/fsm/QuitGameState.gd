extends FSMState

export (NodePath) var level_path
onready var level = get_node(level_path)

func enter_state():
	print("enter ", name)
	level.on_game_over()