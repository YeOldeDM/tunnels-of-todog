extends Node
# PLAYER component of Thing

var P

func _ready():
	if get_parent():
		get_parent().comp["player"] = self
		P = get_parent()
		
		P.visible = true
		P.discovered = true



func _input(event)->void:
	if 'pressed' in event and event.pressed:
		if event.is_action("ui_up"):
			P.step( Vector2( 0, -1 ) )
		if event.is_action("ui_down"):
			P.step( Vector2( 0, 1 ) )
		if event.is_action("ui_left"):
			P.step( Vector2( -1, 0 ) )
		if event.is_action("ui_right"):
			P.step( Vector2( 1, 0 ) )
