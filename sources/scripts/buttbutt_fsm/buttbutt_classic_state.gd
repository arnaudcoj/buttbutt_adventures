extends Node

onready var fsm = get_parent()

export var speed_multiplier = 1
export var distance_before_falling = 128

var quit_ground = false

func update(delta):
	
	if fsm.body.collision_info.below:
		fsm.velocity.y = 0
		

	var input = Vector2()
	var running
	#running has the priority
	if fsm.is_control_pressed(Controls.RunLeft) and not fsm.body.collision_info.left :
		input.x -= 1
	if fsm.is_control_pressed(Controls.RunRight) and not fsm.body.collision_info.right :
		input.x += 1
	
	running = input.x != 0
	
	#if not running => walking
	if not running:
		if fsm.is_control_pressed(Controls.Left) and not fsm.body.collision_info.left :
			input.x -= 1
		if fsm.is_control_pressed(Controls.Right) and not fsm.body.collision_info.right :
			input.x += 1
			
	if not fsm.body.collision_info.below:
		apply_gravity(delta)
	
	# jumping
	if fsm.is_control_pressed(Controls.Jump) and fsm.body.collision_info.below:
		fsm.velocity.y = -fsm.jump_velocity
		
		
	var target_velocity_x = input.x * fsm.move_speed * (2 if running else 1)
#	var target_velocity_y = input.y * move_speed
	
	fsm.velocity.x = lerp(fsm.velocity.x, target_velocity_x, fsm.acceleration_time_grounded if fsm.body.collision_info.below else fsm.acceleration_time_airborne) # use actual smoothdamp 
#	velocity.y = lerp(velocity.y, target_velocity_y, acceleration_time_grounded if fsm.body.collision_info.below else acceleration_time_airborne) # use actual smoothdamp 
	
	fsm.move(fsm.velocity * delta)

func apply_gravity(delta):
	# applying gravity
	fsm.velocity.y += fsm.gravity * delta
	

func on_enter():
	pass
	
func on_leave():
	pass
