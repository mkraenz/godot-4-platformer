class_name Player
extends KinematicBody2D

export (Resource) var move_data # : PlayerMovementData

onready var sprite = $AnimatedSprite
onready var ladders = $LadderCheck

enum State {
	Walk,
	Climb,
}

var velocity := Vector2.ZERO
var state = State.Walk


func _physics_process(delta):
	match state:
		State.Walk:
			move_state(delta)
		State.Climb:
			climb_state(delta)

func climb_state(_delta: float):
	var input_vec = Input.get_vector("move_left", "move_right", "jump", "move_down")
	velocity = input_vec * move_data.climb_speed
	var _a = move_and_slide(velocity, Vector2.UP)

	if input_vec == Vector2.ZERO:
		sprite.play("idle")
	else:
		sprite.play("run")

	if not is_on_ladder():
		state = State.Walk

func move_state(delta: float):
	if is_on_ladder() and Input.is_action_just_pressed("jump"):
		state = State.Climb

	if position.y > move_data.die_over_y:
		die()

	var input_x = Input.get_axis("move_left", "move_right")
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

func is_on_ladder():
	return ladders.is_colliding()


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
