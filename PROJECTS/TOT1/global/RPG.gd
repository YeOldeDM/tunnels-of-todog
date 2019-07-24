extends Node



signal send_message()



# Pixel length of the dungeon map
const CELL_SIZE:int = 32

onready var DATABASE = preload("res://global/DATABASE.tscn").instance()


# Global ref to the Player Thing node
var player

# Can the player recieve input?
# Set to false while in menus and such
var player_active = true

var MAP_DATA = {}
var GAME_TIME = 0.0

# Creates an instance of a Thing from the DATABASE
# Use with spawn_thing() to place it in the dungeon
func create_thing( database_path:String )->Node:
	var new_thing: Node = DATABASE.grab( database_path )
#	things.append( new_thing )
	return new_thing

func destroy_thing( thing:Node )->void:
#	things.remove( things.find( thing ) )
	thing.queue_free()



func map_check_for_solid( cell:Vector2 )->bool:
	var map_block:int = MAP_DATA.map[cell.x][cell.y]
	for thing in get_tree().get_nodes_in_group( "movement_blockers" ):
		print(thing.Name)
		if thing.cell == cell and thing.on_map:
			print(thing.Name)
			return true
	return bool(map_block)



func roll_dice( number:int=1, sides:int=6 )->int:
	var result:int = 0
	
	for i in number:
		result += 1 + randi() % sides
	
	return result
	