extends Node3D
var mapLocation = Vector3(0,0,0)
var mat = null
var mouseInside = false
var terrainType = "d"
var shapeType = 0
var shapeTypes = [BoxMesh.new() , CylinderMesh.new()]

func set_TerrainType(in_terrain):
	terrainType = in_terrain

func set_MapLocation(in_vector):
	mapLocation = in_vector
	
func set_ShapeType(in_shapeType):
	shapeType = in_shapeType

func _ready():
	if shapeType == 1:
		get_node("box").scale.y = 0.5
	var newMesh = shapeTypes[shapeType]
	get_node("box").set_mesh(newMesh)
	var colorBasedOnHeight = Color(mapLocation.y*0.5,mapLocation.y*0.5,mapLocation.y*0.5,1)
	createMaterial(colorBasedOnHeight)
	mouseInside = false

func _process(delta):
	if Input.is_action_just_released("clicked"):
		if mouseInside:
			get_parent().currentHeight = mapLocation.y
	if Input.is_action_pressed("clicked"):
		if mouseInside:
			if get_parent().currentHeight == mapLocation.y:
				get_parent().createSquare(position, mapLocation)

func createMaterial(colorInput):
	var myMaterial = StandardMaterial3D.new()
	var outLine = load("res://materials/outLineMaterial.tres")
	myMaterial.next_pass = outLine
	myMaterial.albedo_color = colorInput
	$box.set_surface_override_material(0, myMaterial)

func _on_area_3d_mouse_entered():
	if !Input.is_action_pressed("clicked"):
		get_parent().currentHeight = mapLocation.y
	mouseInside = true
	
func _on_area_3d_mouse_exited():
	mouseInside = false
