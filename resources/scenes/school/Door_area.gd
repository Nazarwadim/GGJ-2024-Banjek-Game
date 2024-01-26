extends Area2D

signal opened
signal closed
var is_open:bool

func _init():
	monitoring = false

func open():
	is_open = true
	opened.emit()

func close():
	is_open = false
	closed.emit()

