extends RigidBody2D

const GRAVITY = 1800.0
const JUMP_SPEED = 350
var velocity = Vector2()
var walk_speed = 200
var jump_time = 0.0
var initial_position
var MAX_DISTANCE = 200
var thrust = Vector2(0, 250)
var torque = 20000

signal retry

func _ready():
	initial_position = position
	var player = get_parent().get_node("Player")
	self.connect("retry", player, "_on_retry")
	
	
func _integrate_forces(state):
	if abs(initial_position.x - position.x) > MAX_DISTANCE:
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		walk_speed = -1 * walk_speed
		initial_position = position
	var lv = state.get_linear_velocity()
	lv.x = walk_speed
	state.set_linear_velocity(lv)


func _on_Doggo_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.name == "Player":
		emit_signal("retry")
