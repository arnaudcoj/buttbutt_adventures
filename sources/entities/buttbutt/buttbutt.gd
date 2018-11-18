extends KinematicBody2D

func can_snap():
	return $SnapRaycast.is_colliding()

func use_full_collision():
	$FullCollision.disabled = false
	$BodyCollision.disabled = true
	$RaycastCollision.disabled = true
	
func use_snap_collision():
	$FullCollision.disabled = true
	$BodyCollision.disabled = false
	$RaycastCollision.disabled = false
