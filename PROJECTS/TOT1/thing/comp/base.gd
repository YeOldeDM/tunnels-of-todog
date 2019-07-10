extends Node

var P

func _ready():
	if owner:
		P = get_parent()
