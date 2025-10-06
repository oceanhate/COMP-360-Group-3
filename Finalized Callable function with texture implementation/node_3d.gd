extends Node3D

var camera: Camera3D

func _ready():
	var origin = Vector3(1, 2, 0) ##this is the point at which the shape will spawn. 

	##this is a test camera setup 
	camera = Camera3D.new()
	add_child(camera)
	camera.fov = 30.0
	camera.position = Vector3(1, 1, 6)
	camera.look_at(origin, Vector3.UP)

	###this is  a test light setup 
	var light = DirectionalLight3D.new()
	light.rotation_degrees = Vector3(-30, 45, 0)
	add_child(light)

	#this is calling on the shape generator function with all the child nodes. This funciton is flexible and we can add sahpes  later 
	var shape_gen = $ShapeGenerator  #link to the Parent node of all the shapes 
	shape_gen.generate_scene(origin, 2)  # 1 = Tetrahedron, 2 = Pyramid [origin is the spawn point]


func _process(delta):
	#test rotation function, this is just to view what is happening 
	var shape_gen = $ShapeGenerator
	if shape_gen.mesh:
		shape_gen.mesh.rotate_y(deg_to_rad(20) * delta)
