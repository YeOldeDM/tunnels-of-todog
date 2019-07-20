extends Node

signal send_message(txt,format)

enum FORMAT{
	NORMAL
}

func send_message( txt, format = FORMAT.NORMAL ):
	emit_signal("send_message", txt, format )
