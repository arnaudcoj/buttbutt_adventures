extends Node

onready var fsm = get_parent()

onready var idle_state = fsm.get_node("idle")
onready var walk_state = fsm.get_node("walk")
onready var running_state = fsm.get_node("run")
onready var falling_state = fsm.get_node("fall")
onready var climbing_state = fsm.get_node("climb")
onready var jumping_state = fsm.get_node("jump")

export (float, 0, 1) var slide_multiplier = .9

func change_state():
	if not fsm.body.on_ground():
		fsm.change_state(falling_state)
	elif fsm.is_control_pressed(Controls.Jump):
		fsm.change_state(jumping_state)
	elif fsm.is_control_pressed(Controls.Up) and fsm.body.climb_control.can_climb():
		fsm.change_state(climbing_state)
	elif (fsm.is_control_pressed(Controls.RunLeft) or fsm.is_control_pressed(Controls.RunRight)) and not (fsm.is_control_pressed(Controls.RunLeft) and fsm.is_control_pressed(Controls.RunRight)) :
		fsm.change_state(running_state)
	elif (fsm.is_control_pressed(Controls.Left) or fsm.is_control_pressed(Controls.Right)) and not (fsm.is_control_pressed(Controls.Left) and fsm.is_control_pressed(Controls.Right)) :
		fsm.change_state(walk_state)
	elif fsm.velocity.length_squared() < 1:
		fsm.change_state(idle_state)

func on_enter():
	pass

func update(delta):
	fsm.velocity = fsm.velocity * slide_multiplier
	fsm.body.move(fsm.velocity * delta)

func on_leave():
	pass

