extends Node3D
var mapLocation = Vector3(0,0,0)
var terrainType = "b"

func _ready():
	var colorBasedOnHeight = Color(0.9-mapLocation.y*0.1,0.9-mapLocation.y*0.1,0.9-mapLocation.y*0.1,1)
	set_Color(colorBasedOnHeight)

func set_TerrainType(in_terrain):
	terrainType = in_terrain

func set_MapLocation(in_vector):
	mapLocation = in_vector

func set_Mesh(in_meshObject):
	if $MeshInstance3D != null:
		$MeshInstance3D.set_mesh(in_meshObject)
		$MeshInstance3DMove.set_mesh(in_meshObject)
		$MeshInstance3DStatic.set_mesh(in_meshObject)
		$terrainLayer.set_mesh(in_meshObject)
func set_outlineVisibility(in_bool):
	$MeshInstance3D2.visible = in_bool


func set_Color(colorInput):
	var myMaterial = StandardMaterial3D.new()
	#var outLine = load("res://materials/outLineMaterial.tres")
	#myMaterial.next_pass = outLine
	myMaterial.albedo_color = colorInput
	$MeshInstance3D.set_surface_override_material(0, myMaterial)

func _on_area_3d_mouse_entered():
	var shell = get_tree().get_root().get_node("shell")
	var playerController = shell.get_node("container").get_node("mapWorld").get_node("player")
	playerController.set_HoveredBlock(self)
	playerController.set_Height()
