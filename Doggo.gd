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

func _ready():
	initial_position = position

func _integrate_forces(state):
	if Input.is_action_pressed("ui_up"):
		applied_force = thrust.rotated(rotation)
	else:
		applied_force = Vector2()
	var rotation_dir = 0
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
	applied_torque = rotation_dir * torque
