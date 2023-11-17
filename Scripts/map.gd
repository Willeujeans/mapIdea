extends Node3D
@onready var blockScene = load("res://Scenes/block.tscn")
@export var gridSize = 0
var scaleForCubes = Vector3(0.5,0.5,0.5)
var matrixDict = {}
var lockedBlocks = []
var currentHeight = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	populateGrid(gridSize)

func unlockAllBlocks():
	for block in lockedBlocks:
		block.locked = false

func createSquareHere(positionDesired):
	print(positionDesired)
	var newMapBlock = blockScene.instantiate()
	newMapBlock.mapLocation = Vector3(positionDesired.x, positionDesired.y+1, positionDesired.z)
	matrixDict[Vector3(positionDesired.x, positionDesired.y+1, positionDesired.z)] = newMapBlock
	newMapBlock.position = Vector3(matrixDict.get(positionDesired).position.x, matrixDict.get(positionDesired).position.y + scaleForCubes.y, matrixDict.get(positionDesired).position.z)
	newMapBlock.locked = true
	lockedBlocks.append(newMapBlock)
	add_child(newMapBlock)
	
func populateGrid(gridSize):
	var positionForCubes = Vector3(0, 0 ,0)
	for i in gridSize:
		positionForCubes.x = 0
		for j in gridSize:
			var newBlock = blockScene.instantiate()
			newBlock.position = Vector3(positionForCubes.x, 1, positionForCubes.y)
			positionForCubes.x += 0.5
			newBlock.mapLocation = Vector3(j, 0, i)
			matrixDict[Vector3(j, 0, i)] = newBlock
			add_child(newBlock)
		positionForCubes.y += 0.5

#dict where the vector 3 is the key and the object is the value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("clicked"):
		unlockAllBlocks()
	print(currentHeight)
