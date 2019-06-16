extends FSMState

export (NodePath) var splash_node
onready var splash = get_node(splash_node)

func enter_state():
	print("enter ", name)
	splash.open()
	
func leave_state():
	splash.close()

func get_next_state():
	if splash.is_over():
		return $"../MainMenu"
