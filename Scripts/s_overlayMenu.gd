extends Control
@onready var shell = get_tree().get_root().get_node("shell")

func _process(delta):
	if Input.is_action_just_pressed("menu_pull"):
		visible = !visible
