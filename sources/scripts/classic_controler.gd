extends CollisionShape2D

export var speed = 500

onready var body = get_parent()

func _ready():
	pass

func _physics_process(delta):
	var dir = Vector2(0,0)
	
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	
	var motion = dir * speed
	
	body.move(motion * delta)