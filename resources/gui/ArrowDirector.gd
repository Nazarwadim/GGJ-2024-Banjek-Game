extends Sprite2D

@export var player:Player
@export var principal:Principal
@export var arrow_offset_y := -35

func _physics_process(_delta):
	var direction :Vector2 = (principal.global_position - Vector2(player.global_position.x, player.global_position.y + arrow_offset_y))
	print(position - direction)
	look_at(position - direction)
	rotation -= 90
