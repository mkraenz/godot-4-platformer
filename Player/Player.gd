class_name Player
extends KinematicBody2D

# hacky way to force autocompletion
export (Resource) var move_data = preload("res://Player/DefaultPlayerMovementData.tres") as PlayerMovementData

onready var sprite := $AnimatedSprite
onready var ladders := $LadderCheck
onready var jump_buffer_timer := $JumpBufferTimer
onready var coyote_jump_timer := $CoyoteJumpTimer
onready var audio := $AudioAnims
onready var stats := PlayerStats


enum State {
	Walk,
	Climb,
}

var velocity := Vector2.ZERO
var state : int = State.Walk
var double_jump := 1
var buffered_jump := false
var coyote_jump := false

func _ready() -> void:
	var _a = stats.connect("no_health", self, "die")

func _physics_process(delta: float) -> void:
	match state:
		State.Walk:
			move_state(delta)
		State.Climb:
			climb_state(delta)

func climb_state(_delta: float):
	reset_double_jump()
	
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
	var jump_input = Input.is_action_just_pressed("jump")

	if is_on_ladder() and jump_input:
		state = State.Climb

	if is_below_level():
		die()

	var input_x = Input.get_axis("move_left", "move_right")
	var has_horizontal_input = input_x != 0
	if has_horizontal_input:
		sprite.play("run")
		apply_acceleration(input_x, delta)
		sprite.flip_h = input_x > 0
	else:
		sprite.play("idle")
		apply_friction(delta)
		
	apply_gravity()
	
	var jump_released = Input.is_action_just_released("jump")
	# the player can somewhat stop the jump but only close to the initial stremf
	var is_far_from_apex = velocity.y < -move_data.jump_release_force 

	# regular jump
	if is_on_floor() or coyote_jump:
		reset_double_jump()
		if jump_input or buffered_jump:
			jump()
	else:
		sprite.play("jump")
		# double_jump
		if jump_input and double_jump > 0:
			jump()
			double_jump -= 1
		# buffered jump
		elif jump_input and double_jump == 0:
			buffered_jump = true
			jump_buffer_timer.start()
			
		# jump release
		if jump_released and is_far_from_apex:
			# variable jump height
			velocity.y = 0
			
		# fast fall
		if velocity.y > 0:
			velocity.y += move_data.after_jump_apex__extra_gravity
			
	var on_floor_before_moving := is_on_floor() # must come before mve_and_slide
	var in_air_before_moving := not is_on_floor() # must come before move_and_slide

	velocity = move_and_slide(velocity, Vector2.UP)
	
	var just_left_ground := not is_on_floor() and on_floor_before_moving
	var just_landed = is_on_floor() and in_air_before_moving

	if just_left_ground and velocity.y > 0:
		coyote_jump = true
		coyote_jump_timer.start()

	if just_landed:
		audio.play("land")
		# basically we just want to force starting on the idle frame here
		# so that we do not have a looooong jump / run pose on landing
		sprite.play("run", true)

func is_on_ladder() -> bool:
	return ladders.is_colliding()

func is_below_level() -> bool:
	return position.y > move_data.die_over_y

func apply_gravity() -> void:
	 velocity.y += move_data.gravity
	 velocity.y = min(velocity.y, move_data.max_fall_speed)

func apply_friction(delta: float) -> void:
	velocity.x = velocity.move_toward(Vector2.ZERO, \
		move_data.friction * delta).x

func apply_acceleration(input_x: float, delta: float) -> void:
		velocity.x = move_toward(velocity.x, input_x * move_data.max_speed, \
			move_data.acceleration * delta)

func die() -> void:
	stats.reset_singleton()
	var _a = get_tree().reload_current_scene()

func jump() -> void:
	audio.play("jump")
	velocity.y = -move_data.jump_strength
	buffered_jump = false
	coyote_jump = false

func reset_double_jump() -> void:
	double_jump = move_data.double_jumps

func _on_CoyoteJumpTimer_timeout() -> void:
	coyote_jump = false

func _on_JumpBufferTimer_timeout() -> void:
	buffered_jump = false

func take_damage(amount: int) -> void:
	stats.health = stats.health - amount
