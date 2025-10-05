extends Node



func generate_noise_material(tex_size: int = 256, scale_factor: float = 8.0, tile_uv: float = 1.0, seed: int = -1) -> StandardMaterial3D:

	var noise = FastNoiseLite.new()
	if seed == -1:
		randomize()
		seed = randi() % 100000
	noise.seed = seed
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.fractal_octaves = 3
	noise.frequency = 1.0 / max(1.0, absf(scale_factor))

	var img = Image.create(tex_size, tex_size, false, Image.FORMAT_RGBA8)
	for y in range(tex_size):
		for x in range(tex_size):
			var val = noise.get_noise_2d(float(x) / scale_factor, float(y) / scale_factor)
			var brightness = int(clamp(val * 0.5 + 0.5, 0.0, 1.0) * 255.0)
			img.set_pixel(x, y, Color8(brightness, brightness, brightness, 255))

	var tex = ImageTexture.create_from_image(img)

	# Create a StandardMaterial3D using this texture
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(0.482, 1.0, 0.0, 1.0)
	mat.albedo_texture = tex
	mat.uv1_scale = Vector3(tile_uv, tile_uv, 1.0)
	return mat


func apply_material_to_all_meshes(node: Node, mat: Material) -> int:
	var total_applied := 0
	if node is MeshInstance3D:
		node.material_override = mat
		var mesh_data = node.mesh as ArrayMesh
		if mesh_data:
			for i in range(mesh_data.get_surface_count()):
				mesh_data.surface_set_material(i, mat)
		total_applied += 1

	for child in node.get_children():
		total_applied += apply_material_to_all_meshes(child, mat)

	return total_applied
