extends Node2D
var KITTEN = preload("res://Kitten.tscn")
var WIN = preload("res://Win.tscn")
var RETRY = preload("res://RetryState.tscn")
var NEXT_LEVEL
var number_of_kittens = 0

func _ready():
	ready()
	for kitten in range(number_of_kittens):
		var cutie = KITTEN.instance()
		cutie.allow_win = false
		var bed_position = get_node("CatBed").position
		cutie.position = Vector2(bed_position.x, bed_position.y - 50)
		add_child(cutie)

func ready():
	print("ready not implemented")
	push_error("Not implemented")

func _on_retry():
	get_parent().add_child(RETRY.instance())
	
func _on_success():
	var win = WIN.instance()
	if NEXT_LEVEL != null:
		win.next_level = NEXT_LEVEL
	get_parent().add_child(win)
