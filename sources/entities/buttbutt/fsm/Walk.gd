extends FSMState

const SNAP_VECTOR := Vector2(0, 32)
const FLOOR_MAX_ANGLE := deg2rad(50)

var ghost_jump_started := false
var ghost_jump_timer := .0

func get_next_state():
	if Input.is_action_just_pressed("jump"):
		return $"../Jump"
	if not Input.is_action_pressed("walk_left") and not Input.is_action_pressed("walk_right"):
		return $"../Idle"
	if Input.is_action_pressed("walk_left") and Input.is_action_pressed("walk_right"):
		return $"../Idle"
	if not body.is_on_floor():
		if body.ghost_jump_time <= 0 || ghost_jump_timer > body.ghost_jump_time:
			return $"../Fall"
		elif !ghost_jump_started:
			ghost_jump_started = true

func enter_state():
	.enter_state()
	body.skeleton.play("Walk")
	body.velocity.y = 0
	ghost_jump_started = false
	ghost_jump_timer = .0
	
func leave_state():
	.leave_state()
	body.velocity.y = 0

func update_physics(delta):
	body.velocity.y += body.gravity * delta
	
	if Input.is_action_pressed("walk_left"):
		body.velocity.x = clamp(body.velocity.x - body.acceleration_factor * delta, -body.horizontal_speed, -body.horizontal_start_speed)
	elif Input.is_action_pressed("walk_right"):
		body.velocity.x = clamp(body.velocity.x + body.acceleration_factor * delta, body.horizontal_start_speed, body.horizontal_speed)
	
	if body.velocity.x != 0:
		var motion = body.move_and_slide_with_snap(body.velocity, SNAP_VECTOR, Vector2.UP, true, 4, FLOOR_MAX_ANGLE)
		
		if body.is_on_wall() and body.fix_step_height():
			motion += body.move_and_slide_with_snap(body.velocity - motion, SNAP_VECTOR, Vector2.UP, true, 4 , FLOOR_MAX_ANGLE)
		
		body.velocity.y = motion.y

		if body.velocity.x > 0:
			body.skeleton.flip(ButtButtSkeleton.ORIENTATION_RIGHT)
		else:
			body.skeleton.flip(ButtButtSkeleton.ORIENTATION_LEFT)
		
	body.skeleton.set_speed(abs(body.velocity.x) / body.horizontal_speed)
	
	# process ghost_jump
	if ghost_jump_started and ghost_jump_timer < body.ghost_jump_time :
		ghost_jump_timer += delta
	
