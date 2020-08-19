extends KinematicBody2D

const GRAVITY = 1800.0
const JUMP_SPEED = 350
var velocity = Vector2()
var walk_speed = 500
var jump_time = 0.0

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	#var result_front = space_state.intersect_ray(Vector2(position.x + 64, position.y), Vector2(position.x + 64, position.y + 64), [self])
	#var result_back = space_state.intersect_ray(Vector2(position.x + 64, position.y), Vector2(position.x -64, position.y + 64), [self])
	#if !result_front or !result_back:
	#	walk_speed = -walk_speed
	
	velocity.y += delta  * GRAVITY
	#velocity.x = walk_speed
	
	move_and_slide(velocity, Vector2.UP, true, 4, 1.22173)

func deal_with_slope(number_of_slides):
	for slide in range(number_of_slides):
		var collision = get_slide_collision(slide)
		if collision.collider.name == "Player":
			pass
		if is_on_floor() and collision.normal.y < 1.0 and velocity.x != 0.0:
			velocity.y = collision.normal.y
