extends Resource

##This fabric creates Scene by item name
class_name ItemContainerFabric

@export var item_containers:Array[PackedScene]

func get_item(item_name:String) -> Node:
	for item in item_containers:
		var scene_name_lower :String = item._bundled["names"][0].to_lower()
		var item_name_lower :String = item_name.to_lower()
		if scene_name_lower == item_name_lower:
			return item.instantiate()
	push_error("Can`t create object on name:" + item_name + ". Сould you forget to add scene which item is " + item_name)	
	return null
