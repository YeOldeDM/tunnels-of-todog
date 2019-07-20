extends Node
# PLAYER component of Thing

signal player_acted(action_idx)

var P

func _ready():
	if get_parent():
		get_parent().comp["player"] = self
		P = get_parent()
		
		P.visible = true
		P.discovered = true



func _input(event)->void:
	if 'pressed' in event and event.pressed:
		if event.is_action("step_n"):
			P.step( Vector2( 0, -1 ) )
			emit_signal("player_acted",HERO.ACTION.MOVE)
		if event.is_action("step_ne"):
			P.step( Vector2( 1, -1 ) )
			emit_signal("player_acted",HERO.ACTION.MOVE)
		if event.is_action("step_e"):
			P.step( Vector2( 1, 0 ) )
			emit_signal("player_acted",HERO.ACTION.MOVE)
		if event.is_action("step_se"):
			P.step( Vector2( 1, 1 ) )
			emit_signal("player_acted",HERO.ACTION.MOVE)
		if event.is_action("step_s"):
			P.step( Vector2( 0, 1 ) )
			emit_signal("player_acted",HERO.ACTION.MOVE)
		if event.is_action("step_sw"):
			P.step( Vector2( -1, 1 ) )
			emit_signal("player_acted",HERO.ACTION.MOVE)
		if event.is_action("step_w"):
			P.step( Vector2( -1, 0 ) )
			emit_signal("player_acted",HERO.ACTION.MOVE)
		if event.is_action("step_nw"):
			P.step( Vector2( -1, -1 ) )
			emit_signal("player_acted",HERO.ACTION.MOVE)

		if event.is_action("action_wait"):
			emit_signal("player_acted", HERO.ACTION.WAIT)
			MSG.send_message( "You wait for a short time" )






