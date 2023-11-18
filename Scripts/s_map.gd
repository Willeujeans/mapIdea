extends Node3D
@onready var blockScene = load("res://Scenes/block.tscn")
@onready var shell = get_tree().get_root().get_node("shell")
var gridSize = 10
var scaleForCubes = Vector3(0.5,0.5,0.5)
var currentHeight = 0
var matrix = []
var currentTerrain = "w"
var currentShape = 0
# Called when the node enters the scene tree for the first time.

func set_Matrix(in_matrix):
	matrix = in_matrix

func set_MatrixAtIndex(x,y,z, object):
	matrix[x][y][z] = object

func _ready():
	gridSize = shell.get_node("tmp").tmpGridSize
	print("mapManager loaded...")
	set_Matrix($threeDArrayMaker.create3DArray(gridSize))
	populateDefaultGrid(gridSize)

func createSquare(myLocation, mapPosition):
	var newMapBlock = blockScene.instantiate()
	newMapBlock.set_MapLocation(Vector3(mapPosition.x, mapPosition.y+1, mapPosition.z)) 
	newMapBlock.set_TerrainType(currentTerrain)
	newMapBlock.set_ShapeType(currentShape)
	set_MatrixAtIndex(mapPosition.x,mapPosition.y+1,mapPosition.z,newMapBlock)
	newMapBlock.position = Vector3(myLocation.x,myLocation.y+scaleForCubes.y,myLocation.z)
	add_child(newMapBlock)
	
func populateDefaultGrid(gridSize):
	var positionForCubes = Vector3(0, 0 ,0)
	for i in gridSize:
		positionForCubes.x = 0
		for j in gridSize:
			var newBlock = blockScene.instantiate()
			newBlock.position = Vector3(positionForCubes.x, 1, positionForCubes.y)
			positionForCubes.x += 0.5
			newBlock.mapLocation = Vector3(j, 0, i)
			set_MatrixAtIndex(j,0,i,newBlock)
			add_child(newBlock)
		positionForCubes.y += 0.5

func saveCurrentMap():
	var tmp = shell.get_node("tmp")
	var fileExporter = shell.get_node("fileExporter")
	fileExporter.exportFile(tmp.nameOfFile,matrix,gridSize)
