extends Area2D

export var left_action := "walk_left"
export var right_action := "walk_right"

export var sprites = {"walk_left": Object(), "walk_right": Object(), "jump": Object()} 

func _ready():
	update_indicators()
	
func update_indicators():
	if sprites.has(left_action):
		$LeftActionIndicator/Sprite.texture = sprites[left_action]
	if sprites.has(right_action):
		$RightActionIndicator/Sprite.texture = sprites[right_action]