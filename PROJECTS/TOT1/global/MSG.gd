extends Node

"""
Manages messages written to the in-game text feedback.
Upper Left panel of the UI.
"""

signal send_message(txt,format)

enum FORMAT{
	NORMAL
}

func send_message( txt, format = FORMAT.NORMAL ):
	emit_signal("send_message", txt, format )
