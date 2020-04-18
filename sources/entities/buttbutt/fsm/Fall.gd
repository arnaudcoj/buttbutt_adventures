extends FSMState

func get_next_state():
	if Input.is_action_pressed("walk_left") and body.can_grab_left_ledge() \
		or Input.is_action_pressed("walk_right") and body.can_grab_right_ledge():
		return $"../LedgeGrab"
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
	
	if body.is_on_wall():
		body.velocity = body.move_and_slide(body.velocity, Vector2.UP, true, 4, 0.85)
	else:
		body.velocity.y = body.move_and_slide(body.velocity, Vector2.UP, true, 1).y
	
	body.skeleton.set_speed(abs(body.velocity.y) / body.gravity)
