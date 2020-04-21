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
	
	var move_and_collide_result := body.move_and_collide(body.velocity * delta)
	
	var motion := body.velocity
	if move_and_collide_result:
		motion = move_and_collide_result.travel
		if body.is_normal_floor(move_and_collide_result.normal) or body.fix_step_height():
			body.velocity.y = body.gravity * delta
			motion.y = 0
			motion += body.move_and_slide_with_snap(body.velocity - motion, body.snap_vector, Vector2.UP, true, 1 , body.floor_max_angle)
		else:
			motion += body.move_and_slide(body.velocity - motion, Vector2.UP, true, 4 , body.floor_max_angle)
			

	if body.is_on_wall():
		body.velocity = motion
	elif body.is_on_floor():
		body.velocity.y = 0
	else:
		body.velocity.y = motion.y

	body.skeleton.set_speed(abs(body.velocity.y) / body.gravity)
