extends Control

signal slot_mouse_entered(slot)
signal slot_mouse_exited(slot)

signal item_container_mouse_entered(item_container)
signal item_container_mouse_exited(item_container)

signal inventory_container_mouse_entered(inventory_container)
signal inventory_container_mouse_exited(inventory_container)

signal area_using_item_mouse_entered(area_using_item)
signal area_using_item_mouse_exited(area_using_item)

var _area_using_item_containers:Array[Node] = []
var _chest_containers:Array[Node] = []
var _items:Array[Node] = []
var _slots:Array[Node] = []

func _ready():
	await get_tree().create_timer(get_physics_process_delta_time() + 0.1).timeout
	_area_using_item_containers = get_tree().get_nodes_in_group("area_using_item_containers")
	_chest_containers = get_tree().get_nodes_in_group("chest_containers")
	_items = get_tree().get_nodes_in_group("items")
	_slots = get_tree().get_nodes_in_group("slots")
	
	for slot in _slots:
		slot.mouse_entered.connect(_on_item_ui_mouse_entered.bind(slot))
		slot.mouse_exited.connect(_on_item_ui_mouse_exited.bind(slot))
	
	for item in _items:
		item.mouse_entered.connect(_on_item_container_mouse_entered.bind(item))
		item.mouse_exited.connect(_on_item_container_mouse_exited.bind(item))
	
	for chest in _chest_containers:
		chest.mouse_entered.connect(_on_item_container_mouse_entered.bind(chest))
		chest.mouse_exited.connect(_on_item_container_mouse_exited.bind(chest))
	
	for area_using_item in _area_using_item_containers:
		area_using_item.mouse_entered.connect(_on_area_using_item_mouse_entered.bind(area_using_item))
		area_using_item.mouse_exited.connect(_on_area_using_item_mouse_exited.bind(area_using_item))
	
	SignalBus.item_container_tree_entered.connect(_on_item_droped)
	SignalBus.slot_ui_tree_entered.connect(_on_slot_entered_tree)


func _on_slot_entered_tree(slot:Control):
	slot.mouse_entered.connect(_on_item_ui_mouse_entered.bind(slot))
	slot.mouse_exited.connect(_on_item_ui_mouse_exited.bind(slot))

func _on_item_droped(item_container:CollisionObject2D):
	item_container.mouse_entered.connect(_on_item_container_mouse_entered.bind(item_container))
	item_container.mouse_exited.connect(_on_item_container_mouse_exited.bind(item_container))

func _on_item_ui_mouse_entered(item) -> void:
	slot_mouse_entered.emit(item)

func _on_item_ui_mouse_exited(item) -> void:
	slot_mouse_exited.emit(item)

	
func _on_item_container_mouse_entered(item_container) -> void:
	item_container_mouse_entered.emit(item_container)

func _on_item_container_mouse_exited(item_container) -> void:
	item_container_mouse_exited.emit(item_container)


func _on_inventory_container_mouse_entered(inventory_container) -> void:
	inventory_container_mouse_entered.emit(inventory_container)
	
func _on_inventory_container_mouse_exited(inventory_container) -> void:
	inventory_container_mouse_exited.emit(inventory_container)

func _on_area_using_item_mouse_entered(area_using_item) -> void:
	area_using_item_mouse_entered.emit(area_using_item)
	
func _on_area_using_item_mouse_exited(area_using_item) -> void:
	area_using_item_mouse_exited.emit(area_using_item)
