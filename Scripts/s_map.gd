extends Node3D
@onready var blockScene = load("res://Scenes/block.tscn")
@onready var shell = get_tree().get_root().get_node("shell")
@onready var tmp = shell.get_node("tmp")
var gridSize = 4
var scaleForCubes = Vector3(0.5,0.5,0.5)
var currentHeight = 0
var matrix = []
var currentTerrain = "w"
var currentShape = 0
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

func _ready():
	if tmp.importedFilePath == "":
		gridSize = tmp.tmpGridSize
		print("creating new map")
		set_Matrix($threeDArray.create(gridSize))
		createDefaultGrid(gridSize)
	else:
		print("creating imported map")
		var importedMatrix = $mapImporter.createMatrixFromImport(tmp.importedFilePath)
		gridSize = tmp.tmpGridSize
		createMapFromImport(importedMatrix, gridSize)

func set_Matrix(in_matrix):
	matrix = in_matrix

func set_MatrixAtIndex(x,y,z, object):
	matrix[x][y][z] = object
	print("seting: ",x," ",y," ",z," ",object)

#Creates a map from a file that has already been made
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

#Populates a grid based on size with a floor of bedrock
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

#Given the location of a square within the matrix another square will be created above it
func createSquare(myLocation, mapPosition):
	if matrix[mapPosition.x][mapPosition.y+1][mapPosition.z] == null:
		var newMapBlock = blockScene.instantiate()
		newMapBlock.set_MapLocation(Vector3(mapPosition.x, mapPosition.y+1, mapPosition.z)) 
		newMapBlock.set_TerrainType(currentTerrain)
		set_MatrixAtIndex(mapPosition.x,mapPosition.y+1,mapPosition.z,newMapBlock)
		newMapBlock.position = Vector3(myLocation.x,myLocation.y+scaleForCubes.y,myLocation.z)
		add_child(newMapBlock)
		var arrayOfNeighborsChecked = []
		checkFourNeighbors(newMapBlock, arrayOfNeighborsChecked)

#Given a square it will be removed, and the location will be set to null
func destroySquare(squareToBeDestroyed):
	if squareToBeDestroyed.terrainType != "b":
		if squareToBeDestroyed.terrainType != "a":
			matrix[squareToBeDestroyed.mapLocation.x][squareToBeDestroyed.mapLocation.y][squareToBeDestroyed.mapLocation.z] = null
			squareToBeDestroyed.queue_free()


#only need to check up, down, left, right
func checkFourNeighbors(in_cube, arrayOfNeighborsChecked):
	for every in arrayOfNeighborsChecked:
		if in_cube.mapLocation == every.mapLocation:
			return
	arrayOfNeighborsChecked.append(in_cube)
	var arrayOfNeighborsToCall = []
	var mapLoc = in_cube.mapLocation
	var rightLoc = null
	var leftLoc = null
	var topLoc = null
	var bottomLoc = null
	if mapLoc.x+1 < gridSize:
		rightLoc = matrix[mapLoc.x + 1][mapLoc.y][mapLoc.z]
	if mapLoc.x-1 >= 0:
		leftLoc = matrix[mapLoc.x - 1][mapLoc.y][mapLoc.z]
	if mapLoc.z+1 < gridSize:
		topLoc = matrix[mapLoc.x][mapLoc.y][mapLoc.z + 1]
	if mapLoc.z-1 >= 0:
		bottomLoc = matrix[mapLoc.x][mapLoc.y][mapLoc.z - 1]

	var rightBool = false
	var leftBool = false
	var topBool = false
	var bottomBool = false
	
	if rightLoc != null:
		arrayOfNeighborsToCall.append(rightLoc)
		rightBool = true
	if leftLoc != null:
		arrayOfNeighborsToCall.append(leftLoc)
		leftBool = true
	if topLoc != null:
		arrayOfNeighborsToCall.append(topLoc)
		topBool = true
	if bottomLoc != null:
		arrayOfNeighborsToCall.append(bottomLoc)
		bottomBool = true
	#Allsides empty case
	if !rightBool and !leftBool and !topBool and !bottomBool:
		in_cube.set_Mesh(allSides)
		
	#RegularCases
	if rightBool and leftBool and topBool and bottomBool:
		in_cube.set_Mesh(regular)
	if rightBool and leftBool and topBool and !bottomBool:
		in_cube.set_Mesh(regular)
	if rightBool and leftBool and !topBool and bottomBool:
		in_cube.set_Mesh(regular)
	if rightBool and !leftBool and topBool and bottomBool:
		in_cube.set_Mesh(regular)
	if !rightBool and leftBool and topBool and bottomBool:
		in_cube.set_Mesh(regular)
	if rightBool and leftBool and !topBool and !bottomBool:
		in_cube.set_Mesh(regular)
	if !rightBool and !leftBool and topBool and bottomBool:
		in_cube.set_Mesh(regular)
		
	if rightBool and !leftBool and !topBool and bottomBool:
		in_cube.set_Mesh(bottomLeft)
	if !rightBool and leftBool and !topBool and bottomBool:
		in_cube.set_Mesh(bottomRight)
	if rightBool and !leftBool and topBool and !bottomBool:
		in_cube.set_Mesh(topLeft)
	if !rightBool and leftBool and topBool and !bottomBool:
		in_cube.set_Mesh(topRight)
	if rightBool and !leftBool and !topBool and !bottomBool:
		in_cube.set_Mesh(left)
	if !rightBool and leftBool and !topBool and !bottomBool:
		in_cube.set_Mesh(right)
	if !rightBool and !leftBool and topBool and !bottomBool:
		in_cube.set_Mesh(top)
	if !rightBool and !leftBool and !topBool and bottomBool:
		in_cube.set_Mesh(bottom)
	#recursive call to all neighbors
	#MASSIVE ISSUE HERE:
	#this will call every block it's connected to, which means a whole ground level can be called lagging the system
	for each in arrayOfNeighborsToCall:
		checkFourNeighbors(each, arrayOfNeighborsChecked)

func checkNeighbors(in_cube):
	var count = 0
	for x in range(-1,2):
		for z in range(-1,2):
			if x != 0 and z != 0:
				var movedVector = Vector3(in_cube.mapLocation.x + x,in_cube.mapLocation.y,in_cube.mapLocation.z + z)
				if matrix[movedVector.x][movedVector.y][movedVector.z] != null:
					count += 1
	if count >= 9:
		in_cube.set_Mesh(regular)
	else:
		in_cube.set_Mesh(allSides)
	print("I have : ",count, " neighbors")

func saveCurrentMap():
	var fileExporter = shell.get_node("fileExporter")
	fileExporter.exportFile(tmp.nameOfFile,matrix,gridSize)
