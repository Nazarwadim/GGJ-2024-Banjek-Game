extends Resource

## This is static inventory with fixed size items
class_name Inventory
@export var items :Array[Item]

func move_item_in_inventory(from:int, to:int) -> void:
	assert(items[from] != null, "Item in index " + str(from) + " must not be empty")
	assert(items[to] == null, "Item in index " + str(to) + " must be empty")
	items[to] = items[from]
	items[from] = null

func move_item_to_inventory(inventoty:Inventory, from:int, to:int) -> void:
	assert(items[from] != null, "Item in index " + str(from) + " must not be empty")
	assert(inventoty.items[to] == null, "Item in index " + str(to) + " must be empty")
	inventoty.items[to] = items[from]
	items[from] = null

func find_first_free_cell() -> int:
	var iteration:int = 0
	for item in items:
		if item == null:
			return iteration
		iteration +=1
	return -1
