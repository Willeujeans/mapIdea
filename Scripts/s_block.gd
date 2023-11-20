extends Node3D
var mapLocation = Vector3(0,0,0)
var mat = null
var terrainType = "b"
var shapeType = 0
@onready var shell = get_tree().get_root().get_node("shell")
@onready var allSides = load("res://models/allSides.obj")
@onready var bottom = load("res://models/bottom.obj")
@onready var bottomLeft = load("res://models/bottomLeft.obj")
@onready var bottomRight = load("res://models/bottomRight.obj")
@onready var left = load("res://models/left.obj")
@onready var regular = load("res://models/regular.obj")
@onready var right = load("res://models/right.obj")
@onready var top = load("res://models/top.obj")
@onready var topLeft = load("res://models/topLeft.obj")
@onready var topRight = load("res://models/topRight.obj")

func set_TerrainType(in_terrain):
	terrainType = in_terrain

func set_MapLocation(in_vector):
	mapLocation = in_vector
	
func set_ShapeType(in_shapeType):
	shapeType = in_shapeType

func _ready():
	var colorBasedOnHeight = Color(mapLocation.y*0.1,mapLocation.y*0.1,mapLocation.y*0.1,1)
	createMaterial(colorBasedOnHeight)

func createMaterial(colorInput):
	var myMaterial = StandardMaterial3D.new()
	var outLine = load("res://materials/outLineMaterial.tres")
	myMaterial.next_pass = outLine
	myMaterial.albedo_color = colorInput
	$box.set_surface_override_material(0, myMaterial)

func _on_area_3d_mouse_entered():
	var playerController = shell.get_node("container").get_node("mapWorld").get_node("player")
	playerController.set_HoveredBlock(self)
	playerController.set_Height()
