extends KinematicBody2D

const GRAVITY = 1200.0
const WALK_SPEED = 200
const JUMP_SPEED = 400
var velocity = Vector2()

var jump_time = 0.0

func _physics_process(delta):
	velocity.y += delta  * GRAVITY
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
		velocity.x =  WALK_SPEED
	else:
		velocity.x = 0
		
	move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = -JUMP_SPEED
