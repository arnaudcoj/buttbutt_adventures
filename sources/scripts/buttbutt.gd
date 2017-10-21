extends KinematicBody2D

func _ready():
	pass

func flip(to_the_right):
	if to_the_right:
		$buttbutt_skeleton.scale.x = -abs($buttbutt_skeleton.scale.x)
	else:
		$buttbutt_skeleton.scale.x = abs($buttbutt_skeleton.scale.x)
	print($buttbutt_skeleton.scale.x)

func on_ground():
	return test_move(transform, Vector2(0,10))

func get_collision_normal():
	if $raycast.is_colliding():
		return $raycast.get_collision_normal()
	else:
		return null