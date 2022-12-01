extends Control

const file_name = "user://savegame.save"
onready var save_load := SaveLoad
onready var transitions := Transitions

func _ready() -> void:
	visible = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			continue_game()
		else:
			pause()

func pause() -> void:
	get_tree().paused = true
	visible = true
	
func continue_game() -> void:
	get_tree().paused = false
	visible = false

func quit() -> void:
	get_tree().quit()

func _on_ContinueButton_pressed() -> void:
	continue_game()

func _on_QuitButton_pressed() -> void:
	quit()

func save_game() -> void:
	var level = get_tree().current_scene
	save_load.set_save_data(level.id)
	print(save_load.data)
	save_load.save()

func _on_SaveButton_pressed() -> void:
	save_game()

func _on_LoadButton_pressed() -> void:
	if save_load.has_save_file():
		var data = save_load.load()
		PlayerStats.load_from(data["player"])
		var level_id = data["player"]["level_id"]
		var level_path = save_load.ids_to_paths_map[level_id]

		transitions.play_exit_transition()
		yield(transitions, "transition_finished")
		var _a = get_tree().change_scene(level_path)
		transitions.play_enter_transition()

		# we are still in paused mode, so we have to switch back to the game
		continue_game()
