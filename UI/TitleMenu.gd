extends Control

export (PackedScene) var level

func _on_QuitButton_pressed() -> void:
	get_tree().quit()

func _on_StartButton_pressed() -> void:
	var _a = get_tree().change_scene_to(level)
