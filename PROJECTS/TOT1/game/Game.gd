extends Node2D



onready var Dungeon:PackedScene = preload( "res://dungeon/Dungeon.tscn" )

var current_scene setget _set_current_scene

func quit_game()->void:
	get_tree().quit()

func _ready()->void:
	self.current_scene = Dungeon



func _set_current_scene( what:PackedScene )->void:
	if current_scene:
		current_scene.free()
	current_scene = what.instance()
	add_child( current_scene )





