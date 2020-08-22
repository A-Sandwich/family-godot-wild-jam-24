extends Node2D
var WIN = preload("res://Win.tscn")
var RETRY = preload("res://RetryState.tscn")
var NEXT_LEVEL = "res://Level02.tscn"

func _ready():
	pass

func _on_retry():
	get_parent().add_child(RETRY.instance())
	
func _on_success():
	var win = WIN.instance()
	win.next_level = NEXT_LEVEL
	get_parent().add_child(win)
