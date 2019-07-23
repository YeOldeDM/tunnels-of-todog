extends Node






func grab( path:String ):
	var obj = find_node( path )
	return obj.duplicate()
