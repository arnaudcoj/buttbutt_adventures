extends Node
class_name FSM

onready var current_state = self.get_child(0)

func _ready():
	current_state.enter_state()

func _process(delta):
	decide_next_state()
	current_state.update(delta)

func decide_next_state():
	var next_state = current_state.get_next_state()
	if next_state != null:
		current_state.leave_state()
		current_state = next_state
		current_state.enter_state()