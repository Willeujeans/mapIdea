extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var map = get_tree().current_scene.get_node("map")
	if map.currentShape == 1:
		map.currentShape = 0
	else:
		map.currentShape = 1
