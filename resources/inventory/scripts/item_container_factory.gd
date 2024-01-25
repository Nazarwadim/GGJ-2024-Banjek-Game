extends Resource

##This fabric creates Scene by item name
class_name ItemContainerFactory

@export var item_containers:Array[PackedScene]

func get_item(item_name:String) -> Node:
	for item in item_containers:
		var scene_name_lower :String = item._bundled["names"][0].to_lower()
		var item_name_lower :String = item_name.to_lower()
		if scene_name_lower == item_name_lower:
			var item_node := item.instantiate()
			if _has_ItemContainer_node_in_scene(item_node):
				return item_node
			
	push_error("Can`t create object on name \"" + item_name + "\". Сould you forget to add scene which item is " + item_name)	
	return null

func _has_ItemContainer_node_in_scene(item_node) -> bool:
	var item = _get_item_constainer_node_in_scene(item_node)
	if item == null:
		return false
	if item.item == null:
		push_error("in item_container scene has no defined item. Set it in scene")
		return false	
	return true
	
func _get_item_constainer_node_in_scene(item_node) -> ItemContainer:
	if item_node is ItemContainer:
		return item_node
	var children = item_node.get_children()
	for item in children:
		if item is ItemContainer:
			return item
	return null
