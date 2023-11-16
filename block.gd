extends Node3D
var mapLocation = Vector3(0,0,0)
var mat = null
var mouseInside = false
# Called when the node enters the scene tree for the first time.
func _ready():
	mouseInside = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("clicked"):
		if mouseInside:
			print("clicked")
			print(get_parent().matrixDict.get(mapLocation).mapLocation)
			get_node("MeshInstance3D").scale -= Vector3(0.1, 0.1, 0.1)
			get_parent().createSquareHere(mapLocation)

func _on_area_3d_mouse_entered():
	mouseInside = true
	

func _on_area_3d_mouse_exited():
	mouseInside = false
