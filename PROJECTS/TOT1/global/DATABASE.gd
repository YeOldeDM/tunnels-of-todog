extends Node






func grab( path:String ):
	var obj = get_node( path )
	return obj.duplicate()
