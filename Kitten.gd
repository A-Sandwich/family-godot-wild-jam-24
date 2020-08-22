extends RigidBody2D

const GRAVITY = 1800.0
const WALK_SPEED = 500
const JUMP_SPEED = 350
var velocity = Vector2()
var jump = false
var jump_time = 0.0

signal kitten_location

func _ready():
	var player = get_parent().get_node("Player")
	self.connect("kitten_location", player, "_on_kitten_location")
	emit_signal("kitten_location", position)

func _integrate_forces(state):
	var lv = state.get_linear_velocity()
	if Input.is_action_pressed("jump"):
		$Timer.start()
	if jump:
		lv.y =  -500
		state.set_linear_velocity(lv)
		jump = false
	if lv.x > 0: #Probably inefficient but oh well
		emit_signal("kitten_location", position)

func _on_Timer_timeout():
	jump = true
	$Timer.stop()

func _on_kitten_held():
	self.queue_free()
