extends AreaUsingItem

@export var item_factory: ItemContainerFactory

func _on_fixed():
	pass # Replace with function body.


func _on_used():
	get_tree().add_child(item_factory.get_item("diry_bucket"))
