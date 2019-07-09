extends Node2D

class Ray:
	var origin
	var destination
	
	func _init(origin, destination):
		self.origin = origin
		self.destination = destination

onready var space_state = get_world_2d().direct_space_state
onready var side_area = $SideArea
onready var collision_segment = $SideArea/CollisionSegment
onready var raycast_destination = $RaycastDestination

func get_ledge_position():
	var bodies = side_area.get_overlapping_bodies()
	if bodies.size() == 0:
		var raycast_hit = raycast()
		if not raycast_hit.empty():
			return raycast_hit.position
	
	return null

func raycast():
	var ray = get_ray()
	return space_state.intersect_ray(ray.origin, ray.destination, [], side_area.collision_mask)

func get_ray():
	var ray = Ray.new(collision_segment.get_global_transform().xform(collision_segment.shape.b), raycast_destination.get_global_position())
	return ray