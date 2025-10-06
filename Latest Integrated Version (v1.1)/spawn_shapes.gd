extends Node3D

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()  

	var num_points := 20  # how many shapes to generate
	var shape_gen := $ShapeGenerator  

	for i in range(num_points):
		var x = rng.randi_range(-120, 240)
		var z = rng.randi_range(0, 128)
		var y = rng.randi_range(40, 70)
		var shape_type = rng.randi_range(1, 2)  # 1 = tetrahedron, 2 = pyramid

		var origin = Vector3(x, y, z)
		shape_gen.generate_scene(origin, shape_type)
	
	

	
	
	
