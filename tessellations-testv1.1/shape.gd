extends Node3D

var camera : Camera3D
var mat : StandardMaterial3D
var mesh : MeshInstance3D

func _ready():

	
	var tetra = $tetra
	var pyra = $pyra
	
	
	
	var origin = Vector3(1, 2, 0) ## this is the position in which the shape will generate (x, y, z)
	
	mesh = MeshInstance3D.new()
	
	mesh.mesh = tetra.tetrahedron(4, origin) ##note, the first variable of this is height
	##we will want to use a random figure to generate the origin
	
	#mesh.mesh = pyra.pyramid(4, origin)
	
	mat = StandardMaterial3D.new()
	mat.albedo_color = Color(1, 0, 0)
	mesh.set_surface_override_material(0, mat)
	
	camera = Camera3D.new() ##also for testing purposes
	add_child(camera)
	
	camera.position = Vector3(1, 1, 6)
	camera.look_at(origin, Vector3.UP)

	
	var light = DirectionalLight3D.new() ##for testing purposes, to be removed later. 
	light.rotation_degrees = Vector3(0, 30, 0)
	add_child(light)
	
	
	add_child(mesh)

###remove hashes below to test the shapes!!!!
func _process(rotate): ##this is for demo purposes
	mesh.rotate_y(deg_to_rad(20) * rotate)
	
	## so far this is just a test demo for the tesalation of shapes
	## -need to add more shapes 
	## - need to see how they act when there are multiple
	## - need to see how they are implemented.
	## - need to add lines to the shapes for clarity 
