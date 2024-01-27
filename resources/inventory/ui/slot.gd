extends Panel

@onready var _item_texture = $ItemTexture
@onready var _back_ground = $BackGround

@export var item:Item:
	set(value):
		item = value
		if value != null:
			_item_texture.texture = value.texture
		else:
			_item_texture.texture = null
	get:
		return item
	
func _ready():
	SignalBus.slot_ui_tree_entered.emit(self)
	var duplicated_material :Material= _back_ground.material.duplicate()
	_back_ground.material = duplicated_material
	_back_ground.material.set_shader_parameter("line_thickness", 0)

func enable_outline() -> void:
	_back_ground.material.set_shader_parameter("line_thickness", 1.5)

func disable_outline() -> void:
	_back_ground.material.set_shader_parameter("line_thickness", 0)
	
