extends KinematicBody2D

enum State {
	Hover,
	Fall,
	Land,
	Rise
}

onready var animsprite := $AnimatedSprite
onready var start_position := global_position
onready var land_timer := $LandTimer

export var fall_direction := Vector2.DOWN 

var state = State.Hover
var velocity := Vector2.ZERO

const max_speed := 100
const max_rise_speed := 30
const land_wait_time := 1.0 # in secs
const rise_tolerance = 0.002

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	match state:
		State.Hover:
			animsprite.play("rising")
		State.Fall:
			animsprite.play("falling")
			velocity = move_and_slide(velocity, fall_direction * -1)
			if is_on_floor():
				state = State.Land
		State.Land:
			if land_timer.is_stopped():
				land_timer.start(land_wait_time)
			animsprite.play("falling")
		State.Rise:
			animsprite.play("rising")
			position = global_position.move_toward(start_position, delta * max_rise_speed)
			if global_position.distance_to(start_position) < rise_tolerance:
				state = State.Hover

func _on_LandTimer_timeout():
	state = State.Rise


func _on_DetectionArea_body_entered(_body: Player) -> void:
	if state != State.Hover:
		return
	velocity = fall_direction * max_speed
	state = State.Fall
