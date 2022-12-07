extends Area2D

export (String, FILE, "*.tscn") var target_level_path = ""

onready var transitions := Transitions
onready var keyhint := $Keyhint
onready var keyhint_timer := $KeyhintTimer

var on_player := false

func _unhandled_input(_event):
	if on_player and Input.is_action_just_pressed("jump"):
		goto_next_level()

func goto_next_level():
	get_tree().paused = true
	transitions.play_exit_transition()
	yield(transitions, "transition_finished")
	var _a = get_tree().change_scene(target_level_path)
	transitions.play_enter_transition()
	get_tree().paused = false


func _on_Door_body_entered(_body: Player) -> void:
	on_player = true
	keyhint_timer.start()
	
func _on_Door_body_exited(_body: Player) -> void:
	on_player = false
	keyhint_timer.stop()
	keyhint.hide()
		
func _on_KeyhintTimer_timeout() -> void:
	keyhint.show()


