extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var idle_state_path
export (NodePath) var walk_state_path
export (NodePath) var running_state_path
export (NodePath) var falling_state_path
export (NodePath) var climbing_state_path
export (NodePath) var jumping_state_path
export (float, 0, 1) var slide_multiplier = .9

func _ready():
	fsm = get_node(fsm_path)

func change_state():
	if not fsm.body.on_ground():
		fsm.change_state(get_node(falling_state_path))
	elif fsm.is_control_pressed(fsm.Control.Jump):
		fsm.change_state(get_node(jumping_state_path))
	elif fsm.is_control_pressed(fsm.Control.Up) and fsm.body.can_climb():
		fsm.change_state(get_node(climbing_state_path))
	elif (fsm.is_control_pressed(fsm.Control.RunLeft) or fsm.is_control_pressed(fsm.Control.RunRight)) and not (fsm.is_control_pressed(fsm.Control.RunLeft) and fsm.is_control_pressed(fsm.Control.RunRight)) :
		fsm.change_state(get_node(running_state_path))
	elif (fsm.is_control_pressed(fsm.Control.Left) or fsm.is_control_pressed(fsm.Control.Right)) and not (fsm.is_control_pressed(fsm.Control.Left) and fsm.is_control_pressed(fsm.Control.Right)) :
		fsm.change_state(get_node(walk_state_path))
	elif fsm.current_speed.length_squared() < 1:
		fsm.change_state(get_node(idle_state_path))

func on_enter():
	pass

func update(delta):
	fsm.body.move_and_slide(fsm.current_speed * slide_multiplier)
	
	if fsm.body.get_raycast_point() != null:
		fsm.body.move_and_collide(Vector2(0,fsm.body.get_raycast_point().y - fsm.body.position.y))

func on_leave():
#	print("leave slide")
	pass

