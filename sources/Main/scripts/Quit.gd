extends FSMState

func enter_state():
	print("enter ", name)
	get_tree().quit()