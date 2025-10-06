extends Node3D

var grid_size_x: int = 128
var grid_size_z: int = 128
var quad_size: float = 2
var height_scale: float = 35               # Change this to control height of peaks (60 worked best)

var noise := FastNoiseLite.new()
var st := SurfaceTool.new()
var vertices: Array[Vector3] = []

func _ready() -> void:
	# Noise settings (kept as-is)
	noise.noise_type = FastNoiseLite.TYPE_PERLIN        # Can change TYPE_ type to change hill terrain "shape" (Perlin Default)
	noise.fractal_type = FastNoiseLite.FRACTAL_FBM      # Can change FRACTAL_ type to change peak "pointyness" (FBM Default)
	noise.fractal_octaves = 5                           # Higher val for more detail and small ridges (5 Default)
	noise.frequency = 0.02                              # Lower frequency = smooth hills. Higher frequency = Tighter, more frequent bumps. (Use 0.02 for best results)

	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	_peak_generation()
	_ground()

func _peak_generation() -> void:                        # Using FastNoiseLite to assign height to vertices
	for z in range(grid_size_z + 1):
		for x in range(grid_size_x + 1):
			var world_x = float(x) * quad_size
			var world_z = float(z) * quad_size
			var n = noise.get_noise_2d(x, z)
			var h = (n * 0.5 + 0.5) * height_scale
			vertices.append(Vector3(world_x, h, world_z))
			st.add_vertex(vertices.back())

func _ground() -> void:                                 # Initializing the grid and adding quad vertices to the mesh
	for z in range(grid_size_z):
		for x in range(grid_size_x):
			var i0 = z * (grid_size_x + 1) + x
			var i1 = i0 + 1
			var i2 = i0 + (grid_size_x + 1)
			var i3 = i2 + 1

			st.add_index(i0)
			st.add_index(i1)
			st.add_index(i2)
			st.add_index(i1)
			st.add_index(i3)
			st.add_index(i2)

	st.generate_normals()
	var mesh = st.commit()

	var land := MeshInstance3D.new()
	land.mesh = mesh
	# Directional light 3D will be the source of the shadows
	land.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	add_child(land)
