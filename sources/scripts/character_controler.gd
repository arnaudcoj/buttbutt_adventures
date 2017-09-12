extends Node

export (NodePath) var target
var body

export var speed = 500

func _ready():
	body = get_node(target)
	assert(body is KinematicBody2D)

func _process(delta):
	var direction = Vector2(0,0)
	
	if body.test_move(body.transform, Vector2(0,1)):
		if Input.is_action_pressed("ui_left"):
			direction.x -= 1
		if Input.is_action_pressed("ui_right"):
			direction.x += 1
	else:
		direction.y = 1
		
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	
	body.move_and_slide(direction * speed)