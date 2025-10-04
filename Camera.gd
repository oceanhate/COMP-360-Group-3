extends Camera3D

#https://docs.godotengine.org/en/4.5/classes/class_camera3d.html
var cam_fov: float = 60                              # The camera's field of view angle (in degrees)
var cam_near: float = 0.1                            # The distance to the near culling boundary for this camera relative to its local Z axis
var cam_far: float = 1000                            # The distance to the far culling boundary for this camera relative to its local Z axis
var cam_pos: Vector3 = Vector3(128, 72, -30)
var look_at_point: Vector3 = Vector3(128, 6, 128)

func _ready() -> void:
	fov = cam_fov
	near = cam_near
	far  = cam_far
	
	# https://docs.godotengine.org/en/4.5/classes/class_node3d.html#class-node3d-method-look-at-from-position
	# look_at_from_position(position: Vector3, target: Vector3, up: Vector3 = Vector3(0, 1, 0))
	# cam_pos = the spot on the hill; look_at_point = what i'mm looking at
	look_at_from_position(cam_pos, look_at_point, Vector3.UP)   # Moves the node to the specified position, then rotates the node to point toward the target position
