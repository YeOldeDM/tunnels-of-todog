extends Node



signal send_message()



# Pixel length of the dungeon map
const CELL_SIZE:int = 32




var MAP_DATA = {}
var GAME_TIME = 0.0

func map_check_for_solid( cell:Vector2 )->bool:
	return MAP_DATA.map[cell.x][cell.y] == 1



func roll_dice( number:int=1, sides:int=6 )->int:
	var result:int = 0
	
	for i in number:
		result += 1 + randi() % sides
	
	return result
	