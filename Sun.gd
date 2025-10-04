extends DirectionalLight3D

# https://docs.godotengine.org/en/4.5/classes/class_directionallight3d.html
var shadow_max_dist: float = 250      # The maximum distance for shadow splits
# https://docs.godotengine.org/en/4.5/classes/class_light3d.html#property-descriptions
var energy: float = 2                 # The light's strength multiplier (this is not a physical unit)

# https://docs.godotengine.org/en/4.5/classes/class_node3d.html#property-descriptions               
var sun_rotation_degrees: Vector3 = Vector3(10, 140, 0)        #The rotation of this node, in degrees instead of radians

func _ready() -> void:
	light_energy = energy
	rotation_degrees = sun_rotation_degrees
	directional_shadow_max_distance = shadow_max_dist

# https://docs.godotengine.org/en/4.5/classes/class_light3d.html#property-descriptions
	shadow_enabled = true            # If true, the light will cast real-time shadows
	shadow_bias = 0.1               # Used to adjust shadow appearance. Too small a value results in self-shadowing ("shadow acne"), while too large a value causes shadows to separate from casters ("peter-panning")
