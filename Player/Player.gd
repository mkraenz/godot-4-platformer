class_name Player
extends KinematicBody2D

var velocity := Vector2.ZERO

export (Resource) var move_data # : PlayerMovementData

onready var sprite = $AnimatedSprite

func _physics_process(delta):
	if position.y > move_data.die_over_y:
		die()

	var input_x = Input.get_action_strength("move_right") - \
		Input.get_action_strength("move_left")
	if input_x != 0:
		sprite.play("run")
		apply_acceleration(input_x, delta)
		sprite.flip_h = input_x > 0
	else:
		sprite.play("idle")
		apply_friction(delta)
		
	apply_gravity()
	
	var jump_input = Input.is_action_just_pressed("jump")
	var jump_released = Input.is_action_just_released("jump")
	# the player can somewhat stop the jump but only close to the initial stremf
	var is_far_from_apex = velocity.y < -move_data.jump_release_force 
	if is_on_floor() and jump_input:
		velocity.y = -move_data.jump_strength
	
	if not is_on_floor():
		sprite.play("jump")
		
	if not is_on_floor() and jump_released and is_far_from_apex:
		# variable jump height
		velocity.y = 0
	if not is_on_floor() and velocity.y > 0:
		velocity.y += move_data.after_jump_apex__extra_gravity
		
	var was_in_air = not is_on_floor()

	velocity = move_and_slide(velocity, Vector2.UP)
	
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		# basically we just want to force starting on the idle frame here
		# so that we do not have a looooong jump / run pose on landing
		sprite.play("run", true)

func apply_gravity():
	 velocity.y += move_data.gravity
	 velocity.y = min(velocity.y, move_data.max_fall_speed)

func apply_friction(delta: float):
	velocity.x = velocity.move_toward(Vector2.ZERO, \
		move_data.friction * delta).x

func apply_acceleration(input_x: float, delta: float):
		velocity.x = move_toward(velocity.x, input_x * move_data.max_speed, \
			move_data.acceleration * delta)

func die():
	var _a = get_tree().reload_current_scene()
