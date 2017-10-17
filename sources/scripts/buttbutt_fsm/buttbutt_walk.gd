extends Node

export (NodePath) var fsm_path
var fsm
var body

export (NodePath) var idle_state_path
export (NodePath) var falling_state_path
export (NodePath) var jumping_state_path

export var speed = 500
var current_direction = Vector2()

func _ready():
	fsm = get_node(fsm_path)

func update(delta):

	if (fsm.body.get_slide_count() > 0):
		print(fsm.body.get_collision_normal())
		if fsm.body.get_collision_normal() == null or fsm.body.get_collision_normal().dot(Vector2(1,0)) == 0:
			current_direction.x = -1
			current_direction.y = 0
		else:
			current_direction.x = fsm.body.get_collision_normal().y
			current_direction.y = fsm.body.get_collision_normal().x
	
	var direction = current_direction
	if Input.is_action_pressed("ui_right"):
		direction.x *= -1
		direction.y *= 1
	elif Input.is_action_pressed("ui_left"):
		direction.x *= 1
		direction.y *= -1
	else:
		direction.x *= 0
		direction.y *= 0

	fsm.body.move_and_slide(direction.normalized() * speed)
#	fsm.body.move_and_slide(direction.normalized() * speed)

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
	#print("leave walk")
	pass
