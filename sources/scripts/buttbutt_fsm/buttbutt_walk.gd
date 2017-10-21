extends Node

export (NodePath) var fsm_path
var fsm
var body

export (NodePath) var idle_state_path
export (NodePath) var falling_state_path
export (NodePath) var jumping_state_path

export var max_speed = 500
var current_direction = Vector2(-1,0)
var current_speed = 100

func _ready():
	fsm = get_node(fsm_path)

func update(delta):
	#print(fsm.body.get_collision_normal())
	#print(fsm.body.get_slide_collision(0).normal, " ", fsm.body.get_slide_collision(0).normal.dot(Vector2(1,0)))
	if fsm.body.get_collision_normal() != null:
		current_direction.x = fsm.body.get_collision_normal().y
		current_direction.y = fsm.body.get_collision_normal().x
	

	var direction = current_direction
	if Input.is_action_pressed("ui_right"):
		fsm.body.flip(true)
		direction.x *= -1
		direction.y *= 1
		current_speed = min((current_speed * 1.1), max_speed)
	elif Input.is_action_pressed("ui_left"):
		fsm.body.flip(false)
		direction.x *= 1
		direction.y *= -1
		current_speed = min((current_speed * 1.1), max_speed)
		
	#print(direction.normalized())
	fsm.body.move_and_slide(direction.normalized() * current_speed)
	
	if not fsm.body.test_move(fsm.body.transform, Vector2(direction.x,0)) and fsm.body.get_collision_normal() != null:
		fsm.body.move_and_collide(Vector2(0,10))
		#print("fruf")

func change_state():
	if not fsm.body.on_ground():
		fsm.change_state(get_node(falling_state_path))
	elif Input.is_action_pressed("ui_up") :
		fsm.change_state(get_node(jumping_state_path))
	elif not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		fsm.change_state(get_node(idle_state_path))

func on_enter():
	#print("enter walk")
	pass
	
func on_leave():
	current_speed = 100
	current_direction = Vector2(-1,0)
	#print("leave walk")
	pass
