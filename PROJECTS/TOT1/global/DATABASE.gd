extends Node






func grab( path:String ):
	var obj = find_node( path )
	if not obj:
		return
	return obj.duplicate()
