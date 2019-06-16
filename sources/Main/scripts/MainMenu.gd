extends FSMState

export (NodePath) var main_menu_node
onready var main_menu = get_node(main_menu_node)

func enter_state():
	print("enter ", name)
	main_menu.open()
	
func leave_state():
	main_menu.close()

func get_next_state():
	if Input.is_action_pressed("ui_cancel"):
		return $"../Quit"
	elif main_menu.is_over():
		return $"../Level"

