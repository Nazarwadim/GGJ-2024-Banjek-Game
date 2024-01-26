extends Control
@onready var _label = $Label
@onready var _animation_player = $AnimationPlayer

func _on_mouse_object_observer_slot_mouse_entered(slot):
	var item :Item = slot.item
	if item == null:
		return
	_animation_player.play("show")
	_label.text = item.properties["description"]

func _on_mouse_object_observer_slot_mouse_exited(_slot):
	_animation_player.play("hide")
