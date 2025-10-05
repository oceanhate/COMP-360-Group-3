extends Node

func tetrahedron(height: float, origin: Vector3) -> ArrayMesh: 
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var verticies = [
		origin,
		origin + Vector3(-1, -height, 1),
		origin + Vector3(1, -height, 1), 
		origin + Vector3(0, -height, -1),
	]
	
	var faces = [
		[0,1,2],
		[0,2,3],
		[0,3,1],
		[1,3,2]
	]
	
	for face in faces:
		for i in face:
			st.add_vertex(verticies[i])
			
	return st.commit()
