extends Node2D

class_name ButtButtSkeleton

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree

const ORIENTATION_LEFT = 1
const ORIENTATION_RIGHT = -1

func flip(orientation):
	scale.x = orientation