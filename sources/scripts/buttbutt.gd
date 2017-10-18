extends KinematicBody2D

func _ready():
	pass

func on_ground():
	return test_move(transform, Vector2(0,10))

func get_collision_normal():
	if $raycast.is_colliding():
		return $raycast.get_collision_normal()
	else:
		return null