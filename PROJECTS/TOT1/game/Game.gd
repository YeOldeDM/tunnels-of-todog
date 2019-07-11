extends Node2D



onready var Dungeon = preload( "res://dungeon/Dungeon.tscn" )

var current_scene setget _set_current_scene



func _ready():
	self.current_scene = Dungeon




func _set_current_scene( what ):
	if current_scene:
		current_scene.free()
	current_scene = what.instance()
	add_child( current_scene )





