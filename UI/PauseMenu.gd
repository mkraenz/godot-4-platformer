extends Control

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