extends Node

func tetrahedron(height: float, origin: Vector3) -> ArrayMesh: 
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var base_edge = height*.5*.4
	
	var verticies = [
		origin, #v0
		origin + Vector3(-base_edge, -height, base_edge), #v1
		origin + Vector3(base_edge, -height, base_edge), #v2
		origin + Vector3(0, -height, -base_edge), #v3
	]
	
	var faces = [
		[0,1,2], #v0,1,2
		[0,2,3], #v0,2,3
		[0,3,1], #v0,3,1
		[1,3,2]  #v1,3,2
	]
	
	
	for face in faces:
		for i in face:
			st.add_vertex(verticies[i])
			
	return st.commit()
