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
	
	var current_velocity = move_and_slide(velocity, Vector2.UP, true, 4, 1.22173)
	var slides = get_slide_count()
	if slides:
		deal_with_slope(slides)
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = -JUMP_SPEED
	update_animation(current_velocity, slides)

func deal_with_slope(number_of_slides):
	for slide in range(number_of_slides):
		var collision = get_slide_collision(slide)
		if is_on_floor() and collision.normal.y < 1.0 and velocity.x != 0.0:
			velocity.y = collision.normal.y
	
func update_animation(velocity, slides):
	if velocity.x < 0 and not $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	elif velocity.x > 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
	if velocity.x != 0 and slides != 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
