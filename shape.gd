extends Node3D

var camera : Camera3D
var mat : StandardMaterial3D
var mesh : MeshInstance3D

func _ready():

	
	var tetra = $tetra
	
	var origin = Vector3(0, 4, 0) ## this is the position in which the shape will generate (x, y, z)
	
	mesh = MeshInstance3D.new()
	
	mesh.mesh = tetra.tetrahedron(4, Vector3.ZERO) ##note, the first variable of this is height
	##we will want to use a random figure to generate 
	
	mat = StandardMaterial3D.new()
	mat.albedo_color = Color(1, 0, 0)
	mesh.set_surface_override_material(0, mat)
	
	camera = Camera3D.new()
	camera.position = Vector3(1, 1, 6)
	camera.look_at(origin, Vector3.UP)
	add_child(camera)
	
	var light = DirectionalLight3D.new()
	light.rotation_degrees = Vector3(45, -30, 0)
	add_child(light)
	
	
	add_child(mesh)

func _process(rotate): 
	mesh.rotate_y(deg_to_rad(10) * rotate)
	
	## so far this is just a test demo for the tesalation of shapes
	## -need to add more shapes 
	## - need to see how they act when there are multiple
	## - need to see how they are implemented.
