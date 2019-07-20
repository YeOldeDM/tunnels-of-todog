extends Node



var P

export(float) var weight = 0
export(int) var value = 0






func _ready():
	if get_parent():
		get_parent().comp["item"] = self
		P = get_parent()


