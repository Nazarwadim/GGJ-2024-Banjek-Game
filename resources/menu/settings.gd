extends Control
@export var sound_volume : int
@export var music_volume : int
var sound : int

func _ready():
	$main_container/full_option_container/level_of_sound_effects.value = sound_volume
	$main_container/full_option_container/level_of_sound_music.value = music_volume

func print_function(message: String) -> void:
	prints(message)


func _on_button_pressed():
	var optional_callback := print_function.bind("Transition from Settings to Menu")
	GuiTransitions.go_to("menu", optional_callback)



func _on_option_button_item_selected(index):
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN, 0)

	elif index == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED, 0)


func _on_level_of_sound_music_value_changed(value):
	sound = value/5
	if (value == -100):
		AudioServer.set_bus_mute(2,true)
	else:
		AudioServer.set_bus_mute(2,false)
		AudioServer.set_bus_volume_db(2,sound)


func _on_level_of_sound_effects_value_changed(value):
	sound = value/5
	if (value == -100):
		AudioServer.set_bus_mute(1,true)
	else:
		AudioServer.set_bus_mute(1,false)
		AudioServer.set_bus_volume_db(1,sound)
