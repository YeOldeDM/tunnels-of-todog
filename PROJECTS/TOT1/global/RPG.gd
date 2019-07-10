extends Node

# Pixel length of the dungeon map
const CELL_SIZE:int = 32









func roll_dice( number:int=1, sides:int=6 )->int:
	var result:int = 0
	
	for i in number:
		result += 1 + randi() % sides
	
	return result
	