extends Path2D

enum AnimationType {
	Loop,
	Bounce,
}

export(AnimationType) var animation_type := AnimationType.Loop
export(float) var playback_speed = 1.0
export var reverse_direction = false

onready var anims = $AnimationPlayer as AnimationPlayer

func _ready() -> void:
	match animation_type:
		AnimationType.Loop:
			anims.play("move_along_path_loop", -1, playback_speed, reverse_direction)
		AnimationType.Bounce:
			anims.play("move_along_path_bounce", -1, playback_speed, reverse_direction)
		
