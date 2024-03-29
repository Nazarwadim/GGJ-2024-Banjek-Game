extends Control

signal scene_falling

enum ButtonState
{
	ButtonStart,
	ButtonHanging,
	ButtonFalling,
	SceneFalling
}
enum DirrectionRotation
{
	NoRotate,
	RotateLeft,
	RotateRight
}

var button_state : ButtonState
var rotate_state : DirrectionRotation
var rotate_sound_allow : bool
var secondary_rotate_sound_allow : bool
@onready var true_start_animation = get_node("true_start_animation")

@onready var play_button = $play_button_rigid_body
@onready var setting_button = $setting_button_rigid_body
@export var target_rottation : float
@export var start_scene : PackedScene

func _ready():
	button_state = ButtonState.ButtonStart
	rotate_state = DirrectionRotation.NoRotate
	rotate_sound_allow = true
	secondary_rotate_sound_allow = true

func _process(delta):
	match(rotate_state):
		DirrectionRotation.RotateLeft:
			if setting_button.rotation_degrees >= 0:
				setting_button.rotation -= delta*6
				rotate_sound_allow = false
			else : 
				rotate_sound_allow = true

		
		DirrectionRotation.RotateRight:
			if setting_button.rotation_degrees <= target_rottation:
				setting_button.rotation += delta*6
				rotate_sound_allow = false
			else:
				rotate_sound_allow = true

func _on_play_button_mouse_entered():
	$Audio/button_hover_sound.play()


func _on_play_button_mouse_exited():
	$Audio/button_hover_sound.play()


func _on_play_button_button_up():
	$Audio/button_up_sound.play()


func _on_play_button_button_down():
	$Audio/button_down_sound.play()


func _on_play_button_pressed():
	button_state += 1
	match(button_state):
		ButtonState.ButtonHanging:
			_button_hanging()
		ButtonState.ButtonFalling:
			_button_fall()
		ButtonState.SceneFalling:
			_scene_fall()

func _button_hanging():
	play_button.freeze = false
	play_button.gravity_scale = 1
	$Audio/button_hanging_sound.play()

func _button_fall():
	$Audio/button_hanging_sound.stop()
	play_button.inertia = 0
	$pin_nail_button.queue_free()
	$nail.queue_free()

func _scene_fall():
	$border.freeze = false
	setting_button.freeze = false
	true_start_animation.set_current_animation("true_start")
	scene_falling.emit()

func _on_setting_button_mouse_entered():
	rotate_state = DirrectionRotation.RotateLeft
	if rotate_sound_allow and secondary_rotate_sound_allow:
		$Audio/gear_rotate_sound.play()
		rotate_sound_allow = false

func _on_setting_button_mouse_exited():
	rotate_state = DirrectionRotation.RotateRight
	if rotate_sound_allow and secondary_rotate_sound_allow:
		$Audio/gear_rotate_reverse_sound.play()
		rotate_sound_allow = false
	secondary_rotate_sound_allow = true

func print_function(message: String) -> void:
	prints(message)

func _on_setting_button_pressed():
	var optional_callback := print_function.bind("Transition from Menu to Settings")
	rotate_sound_allow = false
	GuiTransitions.go_to("settings", optional_callback)
	secondary_rotate_sound_allow = false
	$Audio/button_hanging_sound.stop()

func _on_true_start_animation_animation_finished(anim_name):
	if(anim_name == "true_start"):
		GuiTransitions.go_to("introduction_to_game")
		$walk.position = Vector2(-182,225)
		$rock.visible = false
		$rock.scale = Vector2(1,1)
