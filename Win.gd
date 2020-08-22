extends CanvasLayer

var next_level

func _ready():
	get_tree().paused = true
	if next_level == null:
		next_level = "res://Level01.tscn"
		$Label.text = "Level Complete!\nThanks for playing my entry into the Godot Wild Jam 24\nPress \"Enter\" to restart the game!"

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene(next_level)
		get_tree().paused = false
		self.queue_free()
