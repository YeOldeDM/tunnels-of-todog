extends CanvasLayer

onready var GameTimeLabel = $Top/Box/Info/GameTime
onready var OutputBox = $Top/Box/Output

onready var DevTools = $DevTools

func _ready():
	MSG.connect( "send_message", self, "_on_message_sent" )

func _input( event ):
	if event.is_action_pressed("show_inventory") and not $InvView.visible:
		$InvView.show()
		for thing in get_parent().inv.get_children():
			$InvView/Box/Contents.append_bbcode( thing.get_context_name() )
			$InvView/Box/Contents.newline()
	if event.is_action_pressed("close_menu") and $InvView.visible:
			$InvView.hide()

func _on_message_sent( txt, format ):
	OutputBox.newline()
	OutputBox.append_bbcode( txt )

func _on_Dungeon_game_time_changed():

	var seconds:int = int(RPG.GAME_TIME) % 60
	var minutes:int = int(RPG.GAME_TIME/60) % 60
	var hours:int = int(RPG.GAME_TIME/3600) % 60
	var days:int = int(RPG.GAME_TIME/86400) % 24
	GameTimeLabel.text = str(days).pad_zeros(2) +":"+\
						str(hours).pad_zeros(2) +":"+\
						str(minutes).pad_zeros(2) +":"+\
						str(seconds).pad_zeros(2)


func _on_DevTools_pressed():
	DevTools.show()
