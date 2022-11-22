extends KinematicBody2D

var velocity := Vector2.ZERO
var fast_fall := false

const max_speed := 50.0
const acceleration := 300.0
const friction := 400.0
const gravity := 5
const after_jump_apex__extra_gravity := 2
const jump_strength = 140
const jump_release_force = 40

func _physics_process(delta):
	var input_vec = Vector2.ZERO
	input_vec.x = Input.get_action_strength("move_right") - \
		Input.get_action_strength("move_left")
	if input_vec != Vector2.ZERO:
		apply_acceleration(input_vec.x, delta)
	else:
		apply_friction(delta)
		
	apply_gravity()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		velocity.y = 0
		fast_fall = false

	var jump_input = Input.is_action_just_pressed("jump")
	var jump_released = Input.is_action_just_released("jump")
	# the player can somewhat stop the jump but only close to the initial stremf
	var is_far_from_apex = velocity.y < -jump_release_force 
	if is_on_floor() and jump_input:
		velocity.y = -jump_strength
		
	if not is_on_floor() and jump_released and is_far_from_apex:
		# variable jump height
		velocity.y = 0
	if not is_on_floor() and velocity.y > 0:
		velocity.y += after_jump_apex__extra_gravity

func apply_gravity():
	 velocity.y += gravity

func apply_friction(delta: float):
	velocity.x = velocity.move_toward(Vector2.ZERO, \
		friction * delta).x

func apply_acceleration(input_x: float, delta: float):
		velocity.x = move_toward(velocity.x, input_x * max_speed, \
			acceleration * delta)
