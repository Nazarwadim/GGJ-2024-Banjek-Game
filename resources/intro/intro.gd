extends AnimationPlayer


@export var menu_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_animation_finished(_anim_name):
	get_tree().change_scene_to_packed(menu_scene)
