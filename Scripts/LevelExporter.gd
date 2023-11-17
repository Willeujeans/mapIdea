extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_save_button_pressed():
	var file = FileAccess.open("D:/godotProjects/mapIdea/SavedData/save_game.md", FileAccess.WRITE)
	file.store_string("hey")
