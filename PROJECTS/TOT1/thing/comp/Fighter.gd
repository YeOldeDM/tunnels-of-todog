extends Node

var P

export(int) var level = 1
export(int) var HP = 5

export(int) var attack = 2
export(int) var defense = 0

var damage_taken = 0


func deal_damage( target ):
	target.take_damage( self.attack )

func take_damage( amt ):
	self.damage_taken += max( 0, amt - self.defense )
	if damage_taken >= self.HP:
		self.die()
	else:
		MSG.send_message( P.get_context_name() + " gets smacked!" )

func die():
	MSG.send_message( P.get_context_name() + " dies." )
	RPG.destroy_thing( P )

func _ready():
	if get_parent():
		get_parent().comp["fighter"] = self
		P = get_parent()
		P.add_to_group( "fighters" )
		print("subscribed fighter to "+P.Name)
