extends CanvasLayer

signal transition_finished

onready var anims = $AnimationPlayer

func play_exit_transition():
	anims.play("exit_level")
	
func play_enter_transition():
	anims.play("enter_level")

func _on_AnimationPlayer_animation_finished(_anim_name: String):
	emit_signal("transition_finished")
