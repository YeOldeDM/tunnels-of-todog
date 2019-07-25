extends Sprite





signal stepped( to_cell )


"""
THING base script.
Everything living on the map
is an instance of me.
"""




# Thing Components. Component nodes
# who are children of this Thing will
# subscribe themselves to this dict.
var comp:Dictionary




# The map cell this Thing is standing on
# Whenever a Thing moves, set this variable
var cell:Vector2 = Vector2() setget _set_cell

# is this Thing visible to the player?
var seen:bool = false setget _set_seen

# has this Thing been discovered by the player?
# goes True the first time it becomes visible
# "always visible" Things are not visible
# until discovered
var discovered:bool = false


# does the Thing currently live on the map?
# False if not spawned yet, is in inventory, etc
var on_map = false 

# This things Name as it appears in its descriptive text
# "A Thing"
export( String ) var Name



export(bool) var blocks_movement setget _set_blocks_movement
export(bool) var blocks_sight setget _set_blocks_sight
export(bool) var always_visible
export(bool) var unique

export( int, "decal", "item", "entity" ) var object_layer #setget _set_object_layer




func get_context_name()->String:
	if unique:
		return Name
	var pre:String = "A"
	if Name[0].to_lower() in ['a','e','i','o','u']:
		pre = "An"
		
	return pre+" "+Name


# Spoooky code! I hope it works:P
func is_seen()->bool:
	return bool( abs( int( always_visible ) + int( seen ) ) )




func can_step( cell:Vector2 )->bool:
	# Return true if this Thing can occupy a cell
	return not RPG.map_check_for_solid( cell )


# Move the Thing to an adjacent cell
# Should do object detection and return 
# appropriate data. Also, it moves the
# Thing if its legal 
func step( direction:Vector2 )->void:
	# Vector input to this should have 
	# axis values of -1|0|1
	
	# "Normalize" the axes
	direction.x = sign( direction.x )
	direction.y = sign( direction.y )
	
	var target_cell = self.cell + direction
	
	var things_at_cell = RPG.get_things_at_cell( target_cell )
	
	var will_step = true
	if is_in_group("fighters"):
		for thing in things_at_cell:
			if thing.is_in_group( "doors" ):
				if not thing.comp["door"].open:
					thing.comp["door"].open = true
					will_step = false
			elif thing.is_in_group( "fighters" ):
				comp["fighter"].deal_damage( thing.comp["fighter"] )
				will_step = false
	
	# check for attack targets, if we are Fighter
#	var attack_target
#	if is_in_group( "fighters" ):
#		for thing in get_tree().get_nodes_in_group( "fighters" ):
#			if thing.cell == target_cell:
#				attack_target = thing
#	if attack_target:
#		comp["fighter"].deal_damage( attack_target.comp["fighter"] )
		
	
	# just move the thing for now...
	if will_step and can_step( target_cell ):
		self.cell = target_cell
	emit_signal( "stepped", self.cell )



func _ready()->void:
	self.z_index = self.object_layer
	
	if blocks_movement:
		add_to_group( "movement_blockers" )

	if blocks_sight:
		add_to_group( "sight_blockers" )




# Setters
func _set_cell(what:Vector2)->void:
	cell = what
	position = cell * RPG.CELL_SIZE

func _set_seen(what:bool)->void:
	seen = what
	self.visible = is_seen()
	
	if seen and not discovered:
		discovered = true

func _set_blocks_movement( what ):
	blocks_movement = what
	if blocks_movement:
		add_to_group("movement_blockers")
	else:
		remove_from_group("movement_blockers")

func _set_blocks_sight( what ):
	blocks_sight = what
	if blocks_sight:
		add_to_group("sight_blockers")
	else:
		remove_from_group("sight_blockers")


	
	
	
	
	
	
	
	
	
	