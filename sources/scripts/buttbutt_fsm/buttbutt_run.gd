extends "res://scripts/buttbutt_fsm/buttbutt_classic_state.gd"

onready var walk_state = fsm.get_node("walk")
onready var stop_state = fsm.get_node("stop")
onready var fall_state = fsm.get_node("fall")
onready var climb_state = fsm.get_node("climb")
onready var jump_state = fsm.get_node("jump")
	
func change_state():
	if not fsm.body.on_ground():
#		fsm.body.move_and_collide(Vector2(0, -fsm.velocity.y * 0.03333))
		if $time_before_fall.is_stopped():
			$time_before_fall.start()
	if fsm.is_control_pressed(Controls.Jump):
		fsm.change_state(jump_state)
	elif fsm.is_control_pressed(Controls.Up) and fsm.body.climb_control.can_climb(): #TODO Jump
		fsm.change_state(climb_state)
	elif not fsm.is_control_pressed(Controls.RunLeft) and not fsm.is_control_pressed(Controls.RunRight):
		if fsm.is_control_pressed(Controls.Left) or fsm.is_control_pressed(Controls.Right):
			fsm.change_state(walk_state)
		else:
			fsm.change_state(stop_state)

func update(delta):
	.update(delta)
	fsm.body.buttbutt_animation.flip(fsm.velocity.x > 0)

func apply_gravity(delta):
	if $time_before_fall.is_stopped():
		# applying gravity
		fsm.velocity.y += fsm.gravity * delta
	else:
		if (fsm.velocity.y > 0):
			fsm.velocity.y *= -1
		else:
			fsm.velocity.y = 0
	
func is_moving_right():
	return fsm.is_control_pressed(Controls.RunRight)
	
func is_moving_left():
	return fsm.is_control_pressed(Controls.RunLeft)

func on_leave():
	$time_before_fall.stop()

func _on_time_before_falling_timeout():
	if not fsm.body.on_ground():
		fsm.change_state(fall_state)