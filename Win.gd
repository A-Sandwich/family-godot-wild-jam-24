extends CanvasLayer

var next_level

func _ready():
	get_tree().paused = true

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene(next_level)
		get_tree().paused = false
		self.queue_free()
