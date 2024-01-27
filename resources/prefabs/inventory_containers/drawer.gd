extends Sprite2D

@onready var sprite: Sprite2D = $"."
@onready var openSound: AudioStreamPlayer = $"../../Sounds/Open"
@onready var closeSound: AudioStreamPlayer = $"../../Sounds/Close"

func _on_chest_container_inventory_opened():
	sprite.frame=1
	openSound.play()


func _on_chest_container_inventory_closed():
	sprite.frame=0
	closeSound.play()
