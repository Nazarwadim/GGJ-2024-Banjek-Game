extends Panel

@onready var item_texture = $ItemTexture
@onready var back_ground = $BackGround

func _ready():
	var duplicated_material :Material= back_ground.material.duplicate(true)
	back_ground.material = duplicated_material
	back_ground.material.set_shader_parameter("line_thickness", 0)

func enable_outline() -> void:
	back_ground.material.set_shader_parameter("line_thickness", 1.5)

func disable_outline() -> void:
	back_ground.material.set_shader_parameter("line_thickness", 0)
	
