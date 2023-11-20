extends Node3D
@onready var blockScene = load("res://Scenes/block.tscn")
@onready var shell = get_tree().get_root().get_node("shell")
var gridSize = 4
var scaleForCubes = Vector3(0.5,0.5,0.5)
var currentHeight = 0
var matrix = []
var currentTerrain = "w"
var currentShape = 0
@onready var allSides = load("res://models/allSides.obj")

func _ready():
	print("mapManager loaded...")
	var tmp = shell.get_node("tmp")
	if tmp.importedFilePath == "":
		gridSize = tmp.tmpGridSize
		print("creating a new map...")
		set_Matrix($threeDArray.create(gridSize))
		createDefaultGrid(gridSize)
	else:
		print("creating map from import...")
		var importedMatrix = $mapImporter.createMatrixFromImport(tmp.importedFilePath)
		gridSize = tmp.tmpGridSize
		createMapFromImport(importedMatrix, gridSize)

func set_Matrix(in_matrix):
	matrix = in_matrix

func set_MatrixAtIndex(x,y,z, object):
	matrix[x][y][z] = object

func createMapFromImport(in_matrix, size):
	set_Matrix(in_matrix)
	var positionForCubes = Vector3(0,0,0)
	for y in size:
		for z in size:
			for x in size:
				if in_matrix[x][y][z] != null:
					in_matrix[x][y][z].position = Vector3(positionForCubes.x, positionForCubes.y, positionForCubes.z)
					add_child(in_matrix[x][y][z])
				positionForCubes.x += scaleForCubes.x
			positionForCubes.x = 0
			positionForCubes.z += scaleForCubes.z
		positionForCubes.z = 0
		positionForCubes.y += scaleForCubes.y

func createDefaultGrid(gridSize):
	var positionForCubes = Vector3(0, 0 ,0)
	for i in gridSize:
		positionForCubes.x = 0
		for j in gridSize:
			var newBlock = blockScene.instantiate()
			newBlock.position = Vector3(positionForCubes.x, 1, positionForCubes.z)
			positionForCubes.x += scaleForCubes.x
			newBlock.mapLocation = Vector3(j, 0, i)
			newBlock.set_TerrainType("b")
			set_MatrixAtIndex(j,0,i,newBlock)
			add_child(newBlock)
		positionForCubes.z += 0.5

func createSquare(myLocation, mapPosition):
	var newMapBlock = blockScene.instantiate()
	newMapBlock.set_MapLocation(Vector3(mapPosition.x, mapPosition.y+1, mapPosition.z)) 
	newMapBlock.set_TerrainType(currentTerrain)
	newMapBlock.set_ShapeType(currentShape)
	set_MatrixAtIndex(mapPosition.x,mapPosition.y+1,mapPosition.z,newMapBlock)
	newMapBlock.position = Vector3(myLocation.x,myLocation.y+scaleForCubes.y,myLocation.z)
	checkNeighbors(newMapBlock)
	add_child(newMapBlock)

func destroySquare(squareToBeDestroyed):
	if squareToBeDestroyed.terrainType != "b":
		if squareToBeDestroyed.terrainType != "a":
			print(squareToBeDestroyed.terrainType)
			matrix[squareToBeDestroyed.mapLocation.x][squareToBeDestroyed.mapLocation.y][squareToBeDestroyed.mapLocation.z] = null
			squareToBeDestroyed.queue_free()

func saveCurrentMap():
	var tmp = shell.get_node("tmp")
	var fileExporter = shell.get_node("fileExporter")
	fileExporter.exportFile(tmp.nameOfFile,matrix,gridSize)


func checkNeighbors(in_cube):
	var count = 0
	for x in range(-1,2):
		for z in range(-1,2):
			var movedVector = Vector3(in_cube.mapLocation.x + x,in_cube.mapLocation.y,in_cube.mapLocation.z + z)
			if matrix[movedVector.x][movedVector.y][movedVector.z] != null:
				if movedVector != in_cube.mapLocation:
					matrix[movedVector.x][movedVector.y][movedVector.z].get_node("box").mesh = allSides
					print(matrix[movedVector.x][movedVector.y][movedVector.z].mapLocation)
