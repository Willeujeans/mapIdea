extends Node3D
var saveDocumentPath = "/Users/willschmitz/Documents/Code/mapIdea/SavedData"
@onready var mapCreationScene = load("res://Scenes/mapCreation.tscn")
@onready var shell = get_tree().get_root().get_node("shell")

# Called when the node enters the scene tree for the first time.
func _ready():
	loadAllSavedFiles(saveDocumentPath)

func loadAllSavedFiles(folder):
	print("searching folder for saved files...")
	var filesArray = shell.get_node("directoryScanner").list_files_in_directory(folder)
	for file in filesArray:
		$fileVisualContainer.createFileVisual(file)
		print("FILE: " , file)


func _on_create_new_map_button_pressed():
	get_parent().get_parent().get_node("sceneChanger").changeSceneTo(get_parent(), mapCreationScene)
