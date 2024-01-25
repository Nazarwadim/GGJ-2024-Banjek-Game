extends Button

@export var button_hover_audio:AudioStreamPlayer
@export var button_down_audio:AudioStreamPlayer
@export var button_up_audio:AudioStreamPlayer
@export var button_pressed_audio:AudioStreamPlayer
var button_state = 0

func _on_mouse_entered():
	button_hover_audio.play()

func _on_mouse_exited():
	button_hover_audio.play()

func _on_button_down():
	button_down_audio.play()

func _on_button_up():
	button_down_audio.play()

func _on_pressed():
	button_state+=1
	match(button_state):
		1:
			_button_hanging()
		2:
			_button_fall()
		3:
			_scene_fall()


func _button_hanging():
	pass

func _button_fall():
	pass

func _scene_fall():
	pass
