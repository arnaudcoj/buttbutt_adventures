extends FSMState

func get_next_state():
#	if Input.is_action_pressed("walk_left") and body.can_grab_left_ledge() \
#		or Input.is_action_pressed("walk_right") and body.can_grab_right_ledge():
#		return $"../LedgeGrab"
	if body.is_on_floor():
		if Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_right"):
			return $"../Walk"
		else:
			return $"../Idle"

func enter_state():
	.enter_state()
	body.skeleton.play("Fall")

func update_physics(delta):
	if Input.is_action_pressed("walk_left") == Input.is_action_pressed("walk_right") or abs(body.velocity.x) > body.horizontal_speed + 10:
		body.velocity.x = sign(body.velocity.x) * max(abs(body.velocity.x) - body.deceleration_factor_fall * delta, 0)
	elif Input.is_action_pressed("walk_left"):
		body.velocity.x = max(body.velocity.x - body.acceleration_factor * delta, -body.horizontal_speed)
	elif Input.is_action_pressed("walk_right"):
		body.velocity.x = min(body.velocity.x + body.acceleration_factor * delta, body.horizontal_speed)
	
	body.velocity.y += body.gravity * delta
	
	var new_velocity := body.move_and_slide(body.velocity, body.up_vector, true, 1, body.floor_max_angle)

	if body.is_on_floor() or body.fix_step_height():
		body.move_and_slide_with_snap(Vector2(body.get_slide_collision(0).remainder.x / delta, 0), body.snap_vector, body.up_vector, true, 2, body.floor_max_angle)
		new_velocity = Vector2(body.velocity.x, 0)
	elif body.is_on_wall():
		body.move_and_slide(Vector2(0, body.get_slide_collision(0).remainder.y / delta), body.up_vector, true, 4 , body.floor_max_angle)
		new_velocity = Vector2(0, body.velocity.y)
	
	body.velocity = new_velocity
	
	body.skeleton.set_speed(abs(body.velocity.y) / body.gravity)
