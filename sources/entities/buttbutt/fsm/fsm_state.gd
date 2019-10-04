extends Node
class_name FSMState

onready var body : KinematicBody2D = $"../.."

func update(delta):
	pass

func update_physics(delta):
	pass
	
func get_next_state():
	pass

func leave_state():
	pass

func enter_state():
	print("enter ", name)
	pass