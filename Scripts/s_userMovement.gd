extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("player Camera loaded")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("rotateUp"):
		rotation = rotation + Vector3(.01,0,0)
	if Input.is_action_pressed("rotateDown"):
		rotation = rotation + Vector3(-.01,0,0)
	if Input.is_action_pressed("up"):
		position = position + Vector3(0,0,-0.1)
	if Input.is_action_pressed("down"):
		position = position + Vector3(0,0,0.1)
	if Input.is_action_pressed("left"):
		position = position + Vector3(-0.1,0,0)
	if Input.is_action_pressed("right"):
		position = position + Vector3(0.1,0,0)
