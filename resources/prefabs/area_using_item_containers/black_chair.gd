extends Sprite2D

@onready var sprite : Sprite2D = $"."

func _on_glue_black_chair_used():
	sprite.frame = 1


func _on_glue_black_chair_fixed():
	sprite.frame = 0
