extends Node

export (NodePath) var fsm_path
var fsm

export var speed = 500
export var gravity_direction = Vector2(0,1)

var inertia_velocity = Vector2()
var gravity_velocity = Vector2()
var player_velocity = Vector2()

func _ready():
	fsm = get_node(fsm_path)

func on_enter():
	inertia_velocity = fsm.current_speed
	gravity_velocity = Vector2()
	player_velocity = Vector2()

func update(delta):
	
	inertia_velocity.x = lerp(inertia_velocity.x, 0, .1)
	
	if not (fsm.is_control_pressed(fsm.Control.RunLeft) and fsm.is_control_pressed(fsm.Control.RunRight)) and not (fsm.is_control_pressed(fsm.Control.Left) and fsm.is_control_pressed(fsm.Control.Right)):
		if fsm.is_control_pressed(fsm.Control.RunLeft):
			player_velocity.x = lerp(player_velocity.x, -speed, .1)
		elif fsm.is_control_pressed(fsm.Control.RunRight):
			player_velocity.x = lerp(player_velocity.x, speed, .1)
		elif fsm.is_control_pressed(fsm.Control.Left):
			player_velocity.x = lerp(player_velocity.x, -speed, .05)
		elif fsm.is_control_pressed(fsm.Control.Right):
			player_velocity.x = lerp(player_velocity.x, speed, .05)

	gravity_velocity.y = lerp(gravity_velocity.y, gravity_direction.y * speed, .2)

	var motion = Vector2(inertia_velocity.x + player_velocity.x, gravity_velocity.y)
	motion.x = clamp(motion.x, -speed, speed)
	motion.y = clamp(motion.y, -speed, speed)

	fsm.body.move_and_slide(motion)

func on_leave():
	pass
