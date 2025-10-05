extends Node3D

@export var tex_size: int = 256      
@export var scale_factor: float = 8.0
@export var randomize_on_start: bool = true
@export var tile_uv: float = 3.0    

var _applied = false  

func _ready() -> void:
	await get_tree().process_frame
	await get_tree().process_frame  
	_apply_material_once()


func _process(_dt: float) -> void:
	if !_applied:
		_apply_material_once()


func _apply_material_once() -> void:
	if randomize_on_start:
		randomize()  

	var noise = FastNoiseLite.new()
	noise.seed = randi() % 100000  
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	noise.fractal_octaves = 4
	noise.frequency = 1.0 / max(1.0, absf(scale_factor))  

	var img = Image.create(tex_size, tex_size, false, Image.FORMAT_RGBA8)
	for y in range(tex_size):
		for x in range(tex_size):
			var val = noise.get_noise_2d(x, y) 
			var brightness = int(clamp(val * 0.5 + 0.5, 0.0, 1.0) * 255.0)
			img.set_pixel(x, y, Color8(brightness, brightness, brightness, 255))

	var tex = ImageTexture.create_from_image(img)

	var custom_mat = StandardMaterial3D.new()
	custom_mat.albedo_color = Color(1.15, 1.15, 1.15) 
	custom_mat.albedo_texture = tex
	custom_mat.uv1_scale = Vector3(tile_uv, tile_uv, 1.0)  

	var meshes_updated = _apply_to_all_meshes(get_tree().current_scene, custom_mat)
	print("TextureNoise.gd: applied material to ", meshes_updated, " mesh instance(s).")
	_applied = (meshes_updated > 0)


func _apply_to_all_meshes(node: Node, mat: Material) -> int:
	var total_applied = 0

	if node is MeshInstance3D:
		var mesh_node = node as MeshInstance3D

		mesh_node.material_override = mat

		var mesh_data = mesh_node.mesh as ArrayMesh
		if mesh_data:
			for i in range(mesh_data.get_surface_count()):
				mesh_data.surface_set_material(i, mat)

		total_applied += 1

	for child in node.get_children():
		total_applied += _apply_to_all_meshes(child, mat)

	return total_applied
