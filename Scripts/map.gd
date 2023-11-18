extends Node3D
@onready var blockScene = load("res://Scenes/block.tscn")
@export var gridSize = 0
var scaleForCubes = Vector3(0.5,0.5,0.5)
var currentHeight = 0
var matrixArray = []
var currentTerrain = "w"
var currentShape = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	matrixArray = create3DArray(gridSize)
	populateGrid(gridSize)

func createSquareHere(myLocation, mapPosition):
	var newMapBlock = blockScene.instantiate()
	newMapBlock.mapLocation = Vector3(mapPosition.x, mapPosition.y+1, mapPosition.z)
	matrixArray[mapPosition.x][mapPosition.y+1][mapPosition.z] = newMapBlock
	newMapBlock.position = Vector3(myLocation.x,myLocation.y+scaleForCubes.y,myLocation.z)
	newMapBlock.terrainType = currentTerrain
	newMapBlock.shapeType = currentShape
	add_child(newMapBlock)
	
func create3DArray(gridSize):
	var array = []
	array.resize(gridSize)    # X-dimension
	for x in gridSize:    # this method should be faster than range since it uses a real iterator iirc
		array[x] = []
		array[x].resize(gridSize)    # Y-dimension
		for y in gridSize:
			array[x][y] = []
			array[x][y].resize(gridSize)    # Z-dimension
	return array
	
func populateGrid(gridSize):
	var positionForCubes = Vector3(0, 0 ,0)
	for i in gridSize:
		positionForCubes.x = 0
		for j in gridSize:
			var newBlock = blockScene.instantiate()
			newBlock.position = Vector3(positionForCubes.x, 1, positionForCubes.y)
			positionForCubes.x += 0.5
			newBlock.mapLocation = Vector3(j, 0, i)
			matrixArray[j][0][i] = newBlock
			add_child(newBlock)
		positionForCubes.y += 0.5

#dict where the vector 3 is the key and the object is the value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
