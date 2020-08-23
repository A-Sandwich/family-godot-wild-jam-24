extends RigidBody2D

const GRAVITY = 1800.0
const WALK_SPEED = 500
const JUMP_SPEED = 350
var velocity = Vector2()
var jump = false
var jump_time = 0.0
var allow_win = true

signal kitten_location
signal success
signal retry

func _ready():
	if not allow_win:
		$meow.visible = false
		return
	var player = get_parent().get_node("Player")
	self.connect("kitten_location", player, "_on_kitten_location")
	self.connect("success", player, "_on_success")
	self.connect("retry", player, "_on_retry")
	emit_signal("kitten_location", position)

func _integrate_forces(state):
	var lv = state.get_linear_velocity()
	if Input.is_action_pressed("jump"):
		$Timer.start()
	if jump:
		lv.y =  -500
		state.set_linear_velocity(lv)
		jump = false
	if allow_win:
		if abs(lv.x) > 0: #Probably inefficient but oh well
			emit_signal("kitten_location", position)
		
		if lv.y > 0 and $FallTimer.is_stopped():
			$FallTimer.start()
		elif lv.y <= 0:
			$FallTimer.stop()

func _on_Timer_timeout():
	jump = true
	$Timer.stop()

func _on_kitten_held():
	self.queue_free()

func _on_Kitten_body_shape_entered(body_id, body, body_shape, local_shape):
	if allow_win and (body.name == "CatBed" or "Kitten" in body.name):
		emit_signal("success")

func _on_FallTimer_timeout():
	$FallTimer.stop()
	emit_signal("retry")
