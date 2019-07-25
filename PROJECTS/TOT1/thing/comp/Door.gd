extends Node

var P

var open = false setget _set_open

export(Texture) var closed_sprite
export(Texture) var open_sprite


func _ready():
	if get_parent():
		get_parent().comp["door"] = self
		P = get_parent()
		P.add_to_group( "doors" )
		print("subscribed door to "+P.Name)


func _set_open( what ):
	open = what
	if open:
		P.texture = open_sprite
		P.blocks_movement = false
		P.blocks_sight = false
	else:
		P.texture = closed_sprite
		P.blocks_movement = true
		P.blocks_sight = true