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
onready var detector := $DetectionArea
onready var dust_effect := $DustEffect
onready var audio := $Audio

export var fall_direction := Vector2.DOWN 

var state = State.Hover
var velocity := Vector2.ZERO

const max_speed := 100
const max_rise_speed := 30
const land_wait_time := 1.0 # in secs
const rise_tolerance := 0.002
const acceleration := 400.0

func _physics_process(delta: float) -> void:
	match state:
		State.Hover:
			animsprite.play("rising")
			if detector.player:
				state = State.Fall
		State.Fall:
			animsprite.play("falling")
			# TODO add acceleration to make this fair
			velocity = velocity.move_toward(fall_direction * max_speed, acceleration * delta)

			velocity = move_and_slide(velocity, fall_direction * -1)
			if is_on_floor():
				state = State.Land
		State.Land:
			dust_effect.emitting = true
			if land_timer.is_stopped():
				audio.play() # only play audio once
				land_timer.start(land_wait_time)
			animsprite.play("falling")
		State.Rise:
			animsprite.play("rising")
			position = global_position.move_toward(start_position, delta * max_rise_speed)
			if global_position.distance_to(start_position) < rise_tolerance:
				state = State.Hover

func _on_LandTimer_timeout():
	state = State.Rise
