tool
extends Path2D

enum AnimationType {
	Loop,
	Bounce,
}

# setters necessary to make the `tool` work
export(AnimationType) var animation_type = AnimationType.Loop setget set_animation_type
export(float) var playback_speed = 1.0 setget set_playback_speed
export var reverse_direction = false setget set_reverse_direction

onready var anims : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animate()
		
func set_playback_speed(speed : float) -> void:
	playback_speed = speed
	animate()
	
func set_reverse_direction(reverse : bool) -> void:
	reverse_direction = reverse
	animate()
	
func set_animation_type(type: int) -> void:
	animation_type = type
	animate()

func animate():
	match animation_type:
		AnimationType.Loop:
			anims.play("move_along_path_loop", -1, playback_speed, reverse_direction)
		AnimationType.Bounce:
			anims.play("move_along_path_bounce", -1, playback_speed, reverse_direction)