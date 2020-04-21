extends FSMState

var long_jump := true

func get_next_state():
#	if Input.is_action_pressed("walk_left") and body.can_grab_left_ledge() \
#		or Input.is_action_pressed("walk_right") and body.can_grab_right_ledge():
#		return $"../LedgeGrab"
	if body.is_on_floor():
		if Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_right"):
			return $"../Walk"
		else:
			return $"../Idle"
	else:
		if body.velocity.y >= 0:
			return $"../Fall"

func update_physics(delta):
	if Input.is_action_just_released("jump"):
		long_jump = false
	
	if !long_jump && body.velocity.y < 0:
		body.velocity.y *= .9
			
	if Input.is_action_pressed("walk_left") == Input.is_action_pressed("walk_right") or abs(body.velocity.x) > body.horizontal_speed:
		body.velocity.x = sign(body.velocity.x) * max(abs(body.velocity.x) - body.deceleration_factor * delta, 0)
	elif Input.is_action_pressed("walk_left"):
		body.velocity.x = max(body.velocity.x - body.acceleration_factor * delta, -body.horizontal_speed)
	elif Input.is_action_pressed("walk_right"):
		body.velocity.x = min(body.velocity.x + body.acceleration_factor * delta, body.horizontal_speed)
	
	body.velocity.y += body.gravity * delta
	
	var motion = body.move_and_slide(body.velocity, Vector2(0, -1), true, 4, 0.85)

	body.velocity = motion

func get_initial_jump_velocity():
	return body.gravity * body.jump_apex_time

func enter_state():
	print("enter ", name)
	long_jump = true
	body.velocity.y = -get_initial_jump_velocity()
	body.skeleton.play("Jump")
	body.skeleton.set_speed(1)
