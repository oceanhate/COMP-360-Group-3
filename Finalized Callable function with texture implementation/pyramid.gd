extends Node

func pyramid(height: float, origin: Vector3) -> ArrayMesh: 
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var base_edge = height*.5*.8
	
	var verticies = [
		origin, #v0
		origin + Vector3(0, -height, base_edge), #v1
		origin + Vector3(-base_edge, -height, 0), #v2
		origin + Vector3(base_edge, -height, 0), #v3
		origin + Vector3(0, -height, -base_edge) #v4
		]
	
	var faces = [
		##note: bottom of pyramid is a square made up of two triangles 
		[0,1,2],
		[0,3,1],
		[0,4,3],
		[0,2,4],
		[1,3,4] , [1,4,2] ##this is the bottom square made up of two triangles
	]
	
	for face in faces:
		var v0 = verticies[face[0]]
		var v1 = verticies[face[1]]
		var v2 = verticies[face[2]]



		st.set_uv(Vector2(0, 0))
		st.add_vertex(v0)

		st.set_uv(Vector2(1, 0))
		st.add_vertex(v1)

		st.set_uv(Vector2(.5, 1))
		st.add_vertex(v2)


		
	st.generate_normals()
	
	return st.commit()
	
	
	
	
