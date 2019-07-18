extends Sprite








"""
THING base script.
Everything living on the map
is an instance of me.
"""




# PROPERTY FLAG ENUMS
#
# To add a new property:
#	1; add it to this list, double its value from the previous (8,16,32...)
#	2; add a string option to var flags (line 66)
enum FLAGS {
	BLOCKS_MOVEMENT=1, #other Things can not normally enter this Thing's cell (monsters, closed doors, etc)
	BLOCKS_SIGHT=2, # FOV counts this Thing's cell as a sight-blocking object (closed doors, fat monster, etc)
	ALWAYS_VISIBLE=4, # A Thing that remains visible even when outside FOV (discovered Items, Stairs, etc)
	UNIQUE=8, # A Thing that has a unique name (the Player, unique monsters/items)
	# Un-Unique Things will show "A Goblin" "A Broadsword" "An Umbral Fiend"
	# Unique Things will show "Vlad The Imaler" "Excalibur" "Todog The Grindy"
}








# Thing Components. Component nodes
# who are children of this Thing will
# subscribe themselves to this dict.
var comp:Dictionary



# Map Icon node representing this 
# Thing may or may not exist
#var icon = null



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

# This things Name as it appears in its descriptive text
# "A Thing"
export( String ) var Name

# This thing's Property Flags
# Property descriptions are found at FLAGS enum ^ ^ ^
export( int, FLAGS, \
	"blocks movement", \
	"blocks sight", \
	"always visible", \
	"unique" \
		 ) var flags

export( int, "decal", "item", "entity" ) var object_layer #setget _set_object_layer







# Spoooky code! I hope it works:P
func is_seen()->bool:
	return bool( abs( int( has_flag( FLAGS.ALWAYS_VISIBLE ) ) + int( seen ) ) )
	

func has_flag( F:int )->bool: #return the state of a property flag
	return flags & F == F



func can_step( cell ):
	# Return true if this Thing can occupy a cell
	return not RPG.map_check_for_solid( cell )


# Move the Thing to an adjacent cell
# Should do object detection and return 
# appropriate data. Also, it moves the
# Thing if its legal :P
func step( direction:Vector2 ):
	# Vector input to this should have 
	# axis values of -1/0/1
	
	# "Normalize" the axes
	direction.x = sign( direction.x )
	direction.y = sign( direction.y )
	
	# just move the thing for now...
	if can_step( cell ):
		self.cell += direction




func _ready():
	self.z_index = self.object_layer



# Setters
func _set_cell(what:Vector2)->void:
	cell = what
	position = cell * RPG.CELL_SIZE

func _set_seen(what:bool)->void:
	seen = what


func _set_visible( what:bool ):
	visible = what

	
	
	
	
	
	
	
	
	
	