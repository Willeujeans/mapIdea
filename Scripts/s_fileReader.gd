extends Node
@onready var shell = get_tree().get_root().get_node("shell")

func stringFromFile(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content
