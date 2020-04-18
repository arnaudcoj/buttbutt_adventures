extends Node2D

class_name ButtButtSkeleton

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state_machine = animation_tree["parameters/StateMachine/playback"]

const ORIENTATION_LEFT = 1
const ORIENTATION_RIGHT = -1

func flip(orientation):
	scale.x = orientation
	
func play(state):
	animation_state_machine.travel(state)

func set_speed(speed):
	animation_tree["parameters/TimeScale/scale"] = speed
