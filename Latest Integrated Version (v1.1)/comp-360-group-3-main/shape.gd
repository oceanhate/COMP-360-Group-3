extends Node3D

var camera: Camera3D
var mesh: MeshInstance3D

# shape_type: 
#   1 = Tetrahedron
#   2 = Pyramid
func generate_scene(origin: Vector3, shape_type: int, height: float = origin.y):
	var TextureNoise = load("res://texture_controller.gd")
	var texture_gen = TextureNoise.new()
	var mat = texture_gen.generate_noise_material()

	var tetra = $tetra
	var pyra = $pyra

	# Create the mesh instance
	mesh = MeshInstance3D.new()

	match shape_type:
		1:
			mesh.mesh = tetra.tetrahedron(height, origin)
		2:
			mesh.mesh = pyra.pyramid(height, origin)
		_:
			push_warning("Invalid shape_type. Use 1 for tetrahedron or 2 for pyramid.")
			return

	add_child(mesh)
	mesh.material_override = mat
