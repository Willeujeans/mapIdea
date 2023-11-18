extends Control
var filePath = ""

func set_filePath(in_filePath):
	filePath = in_filePath

func _on_button_pressed():
	print(filePath)
	#change scene to mapWorld
	#populate the map with imported file
	#set name to the file name
	#set size to file size
	pass
