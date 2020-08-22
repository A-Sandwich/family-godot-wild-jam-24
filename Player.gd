extends KinematicBody2D

const GRAVITY = 1800.0
const WALK_SPEED = 500
const JUMP_SPEED = 1000
var velocity = Vector2()
var jump_time = 0.0
var kitten_location
var KITTEN = preload("res://Kitten.tscn")

signal pickup_kitten
signal retry
signal success

func _ready():
	var held_kitten = get_parent().get_node("Kitten")
	self.connect("pickup_kitten", held_kitten, "_on_kitten_held")
	self.connect("success", get_parent(), "_on_success")
	self.connect("retry", get_parent(), "_on_retry")

func _physics_process(delta):
	velocity.y += delta  * GRAVITY
	if Input.is_action_pressed("move_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x = WALK_SPEED
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
		if collision.collider.name == "Kitten":
			pass
		if is_on_floor() and collision.normal.y < 1.0 and velocity.x != 0.0:
			velocity.y = collision.normal.y
	
func update_animation(velocity, slides):
	if velocity.x < 0 and not $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
		$HeldKitten.position.x = -$HeldKitten.position.x
	elif velocity.x > 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
		$HeldKitten.position.x = -$HeldKitten.position.x
	if velocity.x != 0 and slides != 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if position.distance_to(kitten_location) < 150 and !$HeldKitten.visible:
			emit_signal("pickup_kitten")
			$HeldKitten.visible = true
		elif $HeldKitten.visible:
			var kitten = KITTEN.instance()
			var flipped = -1 if $AnimatedSprite.flip_h else 1
			kitten.position = Vector2(position.x + (flipped * $CollisionShape2D.shape.extents.x), position.y)
			get_parent().add_child(kitten)
			self.connect("pickup_kitten", kitten, "_on_kitten_held")
			$HeldKitten.visible = false

func _on_kitten_location(location):
	kitten_location = location

func _on_retry():
	emit_signal("retry")
func _on_success():
	emit_signal("success")
