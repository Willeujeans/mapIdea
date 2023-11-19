extends Control
@onready var shell = get_tree().get_root().get_node("shell")
@onready var mapWorldScene = load("res://Scenes/mapWorld.tscn")
var filePath = ""
var fileName = ""

func set_filePath(in_filePath):
	filePath = in_filePath
func set_fileName(name):
	fileName = name
	
func _on_button_pressed():
	shell.get_node("tmp").set_importedFilePath(filePath)
	shell.get_node("tmp").nameOfFile = fileName
	shell.get_node("sceneChanger").changeSceneTo(shell.get_node("container"),mapWorldScene)
	#change scene to mapWorld
	#populate the map with imported file
	#set name to the file name
	#set size to file size
	pass
