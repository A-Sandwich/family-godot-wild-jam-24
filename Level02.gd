extends Node2D
var WIN = preload("res://Win.tscn")
var RETRY = preload("res://RetryState.tscn")

func _ready():
	pass

func _on_retry():
	get_parent().add_child(RETRY.instance())
	
func _on_success():
	var win = WIN.instance()
	get_parent().add_child(win)
