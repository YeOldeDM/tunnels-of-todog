extends PanelContainer

signal command( parsed_text )

onready var In = $Box/Input
onready var Out = $Box/Output

var active:bool = false setget _set_active

func _set_active( what:bool )->void:
	active = what
	In.clear()
	if active:
		$Slider.play("Slide")
		In.grab_focus()
	else:
		$Slider.play_backwards("Slide")
	yield($Slider, "animation_finished")
	In.editable = active

func _input(event)->void:
	if "pressed" in event and event.pressed and not event.is_echo():
		if event.is_action_pressed("toggle_console"):
			self.active = !active


func _parse_input( text:String )->void:
	Out.newline()
	Out.append_bbcode( text )
	In.clear()
	var parsed_text:PoolStringArray = text.split(" ")
	emit_signal("command", parsed_text)
	

func _on_write_to_console( what:String )->void:
	Out.newline()
	Out.append_bbcode( "[color=maroon]"+what+"[/color]" )





