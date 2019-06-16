extends FSMState

export (NodePath) var level_root_node
onready var level_root = get_node(level_root_node)

export (PackedScene) var level_to_load
var level_instance

func enter_state():
	print("enter ", name)
	level_instance = level_to_load.instance()
	level_instance.connect("exit", self, "exit_state")
	level_root.add_child(level_instance)
	
func leave_state():
	for node in level_root.get_children():
		node.queue_free()
	
func get_next_state():
	if Input.is_action_pressed("ui_cancel"):
		return $"../Quit"
	elif level_instance.is_game_over():
		return $"../MainMenu"