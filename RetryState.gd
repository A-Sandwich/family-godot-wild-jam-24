extends CanvasLayer

var next_level

func _ready():
	get_tree().paused = true

func _process(delta):
	if Input.is_action_just_pressed("retry"):
		get_tree().reload_current_scene()
		get_tree().paused = false
		self.queue_free()
