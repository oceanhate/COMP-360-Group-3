extends Node

func tetrahedron(height: float, origin: Vector3) -> ArrayMesh: 
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var base_edge = height*.5*.9
	
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
		var v0 = verticies[face[0]]
		var v1 = verticies[face[1]]
		var v2 = verticies[face[2]]

		st.set_uv(Vector2(0, 0))
		st.add_vertex(v0)

		st.set_uv(Vector2(1, 0))
		st.add_vertex(v1)

		st.set_uv(Vector2(0.5, 1))
		st.add_vertex(v2)
		

		
		
	st.generate_normals()

			
	return st.commit()
