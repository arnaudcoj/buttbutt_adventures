extends FSMState

const SNAP_VECTOR := Vector2(0, 32)
const FLOOR_MAX_ANGLE := deg2rad(50)

func get_next_state():
	if Input.is_action_just_pressed("jump"):
		return $"../Jump"
	if Input.is_action_pressed("walk_left") != Input.is_action_pressed("walk_right"):
		return $"../Walk"
	if not body.is_on_floor():
		return $"../Fall"

func enter_state():
	.enter_state()
	body.skeleton.play("Idle")

func update_physics(delta):
	if body.velocity.x != 0:
		body.velocity.x = sign(body.velocity.x) * max(abs(body.velocity.x) - body.deceleration_factor * delta, 0)
	
	if body.velocity != Vector2.ZERO:
		#body.move_and_slide_with_snap(body.velocity, SNAP_LENGTH, Vector2.UP, true, 4, 0.85)
		body.velocity.y = body.move_and_slide_with_snap(body.velocity, SNAP_VECTOR, Vector2.UP, true, 4, FLOOR_MAX_ANGLE).y
		
		if body.velocity.x != 0:
			if body.velocity.x > 0:
				body.skeleton.flip(ButtButtSkeleton.ORIENTATION_RIGHT)
			else:
				body.skeleton.flip(ButtButtSkeleton.ORIENTATION_LEFT)
				
	
	body.skeleton.set_speed(1)
