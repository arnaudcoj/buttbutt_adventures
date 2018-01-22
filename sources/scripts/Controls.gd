extends Node

const Left = 0
const Right = 1
const Up = 2
const Down = 3
const RunLeft = 4
const RunRight = 5
const Jump = 6

func to_string(enum_index):
	if enum_index == Left:
		return "Left"
	if enum_index == Right:
		return "Right"
	if enum_index == Up:
		return "Up"
	if enum_index == Down:
		return "Down"
	if enum_index == RunLeft:
		return "Run Left"
	if enum_index == RunRight:
		return "Run Right"
	if enum_index == Jump:
		return "Jump"
	return "not found"