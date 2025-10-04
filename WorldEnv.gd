extends WorldEnvironment

func _ready() -> void:
	var env = Environment.new()
	environment = env

	# https://docs.godotengine.org/en/4.5/classes/class_proceduralskymaterial.html
	var sky_mat = ProceduralSkyMaterial.new()
	sky_mat.sky_top_color = Color(0.223, 0.472, 0.65)                # Color of the sky at the top. Blends with sky_horizon_color
	sky_mat.sky_horizon_color = Color(0.43, 0.633, 0.836)            # Color of the sky at the horizon. Blends with sky_top_color

	var sky = Sky.new()
	sky.sky_material = sky_mat

# https://docs.godotengine.org/en/4.5/classes/class_environment.html
	env.background_mode = Environment.BG_SKY        # Displays a user-defined sky in the background
	env.sky = sky
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR     # The ambient light source to use for rendering materials and global illumination
	env.ambient_light_color  = Color(1, 1, 1, 1)                 # The ambient light's Color
	env.ambient_light_energy = 0.08       # The ambient light's energy. The higher the value, the stronger the light
