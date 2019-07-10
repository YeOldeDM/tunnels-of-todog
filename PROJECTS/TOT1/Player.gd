extends Node2D
"""
THIS IS THE BAD PLAYER SCRIPT
DON'T USE ME!
"""
const CELL_SIZE:int = 32

var cell:Vector2 = Vector2() setget _set_cell

func step(direction:Vector2)->void:
	self.cell += direction


func _input(event)->void:
	if 'pressed' in event and event.pressed:
		if event.is_action("ui_up"):
			step( Vector2( 0, -1 ) )
		if event.is_action("ui_down"):
			step( Vector2( 0, 1 ) )
		if event.is_action("ui_left"):
			step( Vector2( -1, 0 ) )
		if event.is_action("ui_right"):
			step( Vector2( 1, 0 ) )




func _set_cell(what:Vector2)->void:
	cell = what
	position = cell * CELL_SIZE