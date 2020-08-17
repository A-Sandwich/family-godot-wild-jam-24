extends KinematicBody2D

const GRAVITY = 1800.0
const WALK_SPEED = 500
const JUMP_SPEED = 350
var velocity = Vector2()

var jump_time = 0.0

func _physics_process(delta):
	velocity.y += delta  * GRAVITY
	
	var current_velocity = move_and_slide(velocity, Vector2.UP, true, 4, 1.22173)
	var slides = get_slide_count()
	if slides:
		deal_with_slope(slides)
	if is_on_floor() and Input.is_action_pressed("jump"):
		$Timer.start()

func deal_with_slope(number_of_slides):
	for slide in range(number_of_slides):
		var collision = get_slide_collision(slide)
		if collision.collider.name == "Player":
			visible = false
			pass
		if is_on_floor() and collision.normal.y < 1.0 and velocity.x != 0.0:
			velocity.y = collision.normal.y


func _on_Timer_timeout():
	velocity.y = -JUMP_SPEED
	$Timer.stop()
