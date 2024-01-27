extends Control
@export var start_scene : PackedScene 
@export var introduction_duration : int
var mini_timer : float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.visible:
		mini_timer += _delta
		if (mini_timer >= introduction_duration):
			get_tree().change_scene_to_packed(start_scene)
