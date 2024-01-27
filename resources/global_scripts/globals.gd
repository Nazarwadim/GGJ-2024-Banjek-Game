extends Node

const BREAK_TIME = 150
const LESSON_TIME = 450

enum TimeState
{
	Break,
	Lesson
}
var current_time_state := TimeState.Lesson
var current_time:int = 43

var _update_timer:Timer

var school_mood:int = 10:
	set(value):
		school_mood = value
		SignalBus.global_mood_changed.emit(value)
	get:
		return school_mood
		
func _ready():
	_update_timer = Timer.new()
	add_child(_update_timer)
	_update_timer.wait_time = 1
	_update_timer.timeout.connect(_on_update_timer_timeout)
	_update_timer.start()
	
func _on_update_timer_timeout() -> void:
	current_time += 1
	if current_time > 60:
		current_time = 1
		current_time_state = TimeState.Lesson
		SignalBus.lessons_started.emit()
	elif current_time % 45 == 0:
		current_time_state = TimeState.Break
		SignalBus.break_started.emit()
	elif current_time % 3 == 0:
		school_mood -= 1
