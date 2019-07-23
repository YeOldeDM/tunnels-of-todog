extends Node



var P

export(float) var weight = 0
export(int) var value = 0



func pickup():
	pass

func drop():
	pass


func _ready():
	if get_parent():
		get_parent().comp["item"] = self
		P = get_parent()
		P.add_to_group( "items" )
		print("subscribed item to "+P.Name)


