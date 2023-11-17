extends Node3D
var mapLocation = Vector3(0,0,0)
var mat = null
var mouseInside = false
var locked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var colorMod = mapLocation.y*0.5
	var moddedColor = Color(colorMod,colorMod,colorMod,1)
	print(moddedColor)
	var myMaterial = StandardMaterial3D.new()
	myMaterial.albedo_color = moddedColor
	var myMesh = get_node("MeshInstance3D")
	myMesh.set_surface_override_material(0, myMaterial)
	mouseInside = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("clicked"):
		if mouseInside:
			get_parent().currentHeight = mapLocation.y
	if Input.is_action_pressed("clicked"):
		if mouseInside:
			if get_parent().currentHeight == mapLocation.y:
				print("clicked")
				print(get_parent().matrixDict.get(mapLocation).mapLocation)
				get_parent().createSquareHere(mapLocation)

func _on_area_3d_mouse_entered():
	if !Input.is_action_pressed("clicked"):
		get_parent().currentHeight = mapLocation.y
	mouseInside = true
	

func _on_area_3d_mouse_exited():
	mouseInside = false
