extends Sprite2D

@onready var sprite : Sprite2D = $"."

func _on_area_using_item_container_fixed():
	sprite.frame = 0


func _on_area_using_item_container_used():
	sprite.frame = 1
