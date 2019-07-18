extends PanelContainer


signal alpha_selected( idx )

onready var menu = $"Box/Box/Menu"
onready var out = $"Box/Box/Output"

var test_data = ["Human", "Elf", "Dwarf", "Halfling"]


const alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                    'N', 'O', 'P', 'Q','R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

func make_menu( from_data ):
	var text = ""
	for i in from_data.size():
		text += alphabet[i] + ") " + from_data[i] + "\n"
	menu.text = text

func _ready():
	connect( "alpha_selected", self, "_on_alpha_selected" )
	make_menu( test_data )


func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo():
		var t = event.as_text()
		if t in alphabet:
			emit_signal( "alpha_selected", alphabet.find( t ) )


func _on_alpha_selected( idx ):
	if idx < test_data.size():
		out.text = "You chose " + test_data[idx]