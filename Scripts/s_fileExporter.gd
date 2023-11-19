extends Node
@onready var shell = get_tree().get_root().get_node("shell")
func exportFile(in_fileName, in_matrix, in_size):
	var mapString = $mapEncoder.encodeMap(in_matrix,in_size)
	var path = shell.get_node("tmp").saveFilePath + in_fileName
	write_file(path, mapString)

static func write_file(file_name, string):
	var file = FileAccess.open(file_name, FileAccess.WRITE)
	file.store_string(string)
	file.close()
