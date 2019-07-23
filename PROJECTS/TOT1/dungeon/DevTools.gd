extends WindowDialog

onready var SpawnTree = $Tabs/SpawnThing/Box/Tree

func make_spawntree():
	var dat = get_parent().DATABASE
	var root = SpawnTree.create_item()
	

func _ready():
	pass
