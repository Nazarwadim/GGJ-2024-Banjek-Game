extends Area2D
class_name AreaUsingItem

@export var item_can_use:Item
@export var time_to_use_ms:int = 600
@export var happiness_increase:int
@export var remove_item_after_use = true

signal used
signal fixed
var is_used:bool

func _init():
	monitoring = false

func _ready():
	if item_can_use == null:
		push_error("Set item to use in area using item. Node name:" + name)

func use():
	is_used = true
	used.emit()
	Globals.school_mood = Globals.school_mood + happiness_increase

func fix():
	is_used = false
	fixed.emit()


