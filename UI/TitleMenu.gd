extends Control

export (PackedScene) var level

func _unhandled_input(_event: InputEvent):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().set_input_as_handled() # stop event propagation
		_on_StartButton_pressed()

func _on_QuitButton_pressed() -> void:
	get_tree().quit()

func _on_StartButton_pressed() -> void:
	var _a = get_tree().change_scene_to(level)
