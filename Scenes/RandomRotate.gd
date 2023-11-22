extends MeshInstance3D
var rng = RandomNumberGenerator.new()
var my_random_number
var originalScale
var canGo = false
func _ready():
	originalScale = scale
	var my_random_number = rng.randf_range(.05, 1)
	await get_tree().create_timer(my_random_number).timeout
	canGo = true

func _process(delta):
	if canGo:
		if scale.x == originalScale.x:
			scale.x += 0.02
			scale.z += 0.02
		if scale.x == originalScale.x+0.05:
			scale.x -= 0.02
			scale.z -= 0.02
		shaking(delta)
	
var is_right = true
var intensity = 0.01

func shaking(delta):
	if(is_right):
		rotation.y += sin(delta*intensity)
	else:
		rotation.y -= sin(delta*intensity)
	if rotation.y < -0.01:
		is_right = true
	if rotation.y > 0.01:
		is_right = false
