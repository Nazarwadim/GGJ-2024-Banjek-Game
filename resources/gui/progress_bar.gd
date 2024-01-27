extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	value = Globals.school_mood
	SignalBus.global_mood_changed.connect(_on_shool_mood_changed)

func _on_shool_mood_changed(new_value):
	value = new_value
