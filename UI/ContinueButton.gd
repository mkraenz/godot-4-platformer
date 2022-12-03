extends Button

var save_load = SaveLoad
var transitions = Transitions

var acted = false

func _ready() -> void:
	disabled = not save_load.has_save_file()

# Warning: Only call this function if the button is _not_ disabled.
func act() -> void:
	if not acted:
		acted = true
		continue_game()

func continue_game():
	var data = save_load.load()
	PlayerStats.load_from(data["player"])
	var level_id = data["player"]["level_id"]
	var level_path = save_load.ids_to_paths_map[level_id]

	transitions.play_exit_transition()
	yield(transitions, "transition_finished")
	var _a = get_tree().change_scene(level_path)
	transitions.play_enter_transition()

func _on_ContinueButton_pressed() -> void:
	act()