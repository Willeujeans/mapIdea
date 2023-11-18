extends Node
var saveDocumentPath = "/Users/willschmitz/Documents/Code/mapIdea/SavedData"
@onready var blockScene = load("res://Scenes/block.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Importing Map...")
	var importedMapString = openFile(saveDocumentPath + "/save_game.md")
	generateArrayFromString(importedMapString)

func checkForNumber(number):
	if number == "0" || number == "1" || number == "2" || number == "3" || number == "4" || number == "5" || number == "6" || number == "7" || number == "8" || number == "9":
		return true
	else:
		return false

func generateArrayFromString(mapString):
	var splitMap = mapString.split(" ")
	var importedGridSize = splitMap[0]
	var data = splitMap[1]
	print("Size of Imported Map: " , importedGridSize)
	print("Data: " , data)
	var count = ""
	var currentTerrain = "a"
	var arrayOfBlocks = []
	for letter in data:
		if checkForNumber(letter):
			count += letter
		else:
			currentTerrain = letter
			for n in int(count):
				arrayOfBlocks.append(currentTerrain)
			count = ""
	printArray(arrayOfBlocks)
	createBlocks(arrayOfBlocks, int(importedGridSize))

func printArray(in_array):
	for n in in_array:
		print(n)

func createBlocks(in_array, gridSize):
	var matrix = create3DArray(gridSize)
	var index = Vector3(0,0,0)
	for n in in_array:
		var newBlock = blockScene.instantiate()
		newBlock.terrainType = n
		matrix[index.x][index.y][index.z] = newBlock
		index.x += 1
		if index.x >= gridSize:
			index.x = 0
			index.z += 1
		if index.z >= gridSize:
			index.z = 0
			index.y += 1
		if index.y >= gridSize:
			print("EX" , matrix[5][5][5].terrainType)
			print("DONE")

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

func openFile(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	return content

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
