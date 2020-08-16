extends KinematicBody2D

const GRAVITY = 1800.0
const WALK_SPEED = 500
const JUMP_SPEED = 600
var velocity = Vector2()

var jump_time = 0.0

func _physics_process(delta):
	velocity.y += delta  * GRAVITY
	if Input.is_action_pressed("move_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x =  WALK_SPEED
	else:
		velocity.x = 0
		
	#move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	velocity.y = move_and_slide(velocity, Vector2(0, -1)).y
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = -JUMP_SPEED
	update_animation(velocity)
	
func update_animation(velocity):
	if velocity.x < 0 and not $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	elif velocity.x > 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
	if velocity.x != 0 and velocity.y == 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
