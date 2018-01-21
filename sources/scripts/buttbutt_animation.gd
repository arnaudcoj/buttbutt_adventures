extends Node2D

func flip(to_the_right):
	if to_the_right:
		scale.x = -abs(scale.x)
	else:
		scale.x = abs(scale.x)