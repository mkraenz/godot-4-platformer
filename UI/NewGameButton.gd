extends Button

export (PackedScene) var level

var transitions = Transitions

var acted = false

func act() -> void:
	if not acted:
		acted = true
		start_new_game()
	
func start_new_game():
	transitions.play_exit_transition()
	yield(transitions, "transition_finished")
	var _a = get_tree().change_scene_to(level)
	transitions.play_enter_transition()

func _on_NewGameButton_pressed() -> void:
	act()