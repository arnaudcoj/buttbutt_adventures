extends Node

onready var fsm = get_parent()

onready var falling_state = $"../walk"

export var speed = 500

var reached_top

func change_state():
	if (fsm.is_control_pressed(Controls.Left) or fsm.is_control_pressed(Controls.Right) or fsm.is_control_pressed(Controls.RunLeft) or fsm.is_control_pressed(Controls.RunRight)) and not fsm.body.climb_control.can_climb(): #TODO control jump
		fsm.change_state(falling_state)

func on_enter():
	fsm.velocity = Vector2()

func update(delta):
	var direction = Vector2(0,0)
	var motion = Vector2(0,0)
	
	if fsm.is_control_pressed(Controls.Left):
		direction.x -= 1
	if fsm.is_control_pressed(Controls.Right):
		direction.x += 1
	if fsm.is_control_pressed(Controls.RunLeft):
		direction.x -= 1.5
	if fsm.is_control_pressed(Controls.RunRight):
		direction.x += 1.5
	
	
	if fsm.is_control_pressed(Controls.Up) and fsm.body.climb_control.can_climb_up():
		direction.y -= 1
	if fsm.is_control_pressed(Controls.Down) and fsm.body.climb_control.can_climb_down():
		direction.y += 1
	
	fsm.velocity = direction.normalized() * speed
	motion = fsm.velocity * delta
	if motion.x == 0 and motion.y != 0:
		motion.x = clamp(fsm.body.climb_control.get_climb_area_center().x - fsm.body.position.x, -speed * delta * 0.5, speed * delta * 0.5)
	
	fsm.body.move(motion)

func on_leave():
	pass
