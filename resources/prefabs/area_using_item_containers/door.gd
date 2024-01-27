extends Sprite2D

@onready var sprite : Sprite2D = $"."

func _on_door_area_closed():
	if sprite.flip_h == true:
		sprite.global_position.x += 32
	else:
		sprite.global_position.x -= 32
	$"../../AnimationPlayer".play("door_opened")

func _on_door_area_opened():
	if sprite.flip_h != true:
		sprite.global_position.x += 32
	else:
		sprite.global_position.x -= 32
	$"../../AnimationPlayer".play("door_closed")
