extends FSM
class_name PhysicsFSM

func _physics_process(delta):
	current_state.update_physics(delta)
	