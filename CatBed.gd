extends KinematicBody2D

const GRAVITY = 1800.0
var velocity = Vector2()

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	move_and_slide(velocity, Vector2.UP, true, 4, 1.22173)
