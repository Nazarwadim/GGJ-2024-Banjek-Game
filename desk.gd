extends Sprite2D

@onready var sprite : Sprite2D = $"."

func _on_area_using_item_container_used():
	sprite.frame = 2
	


func _on_area_using_item_container_fixed():
	pass # Replace with function body.

