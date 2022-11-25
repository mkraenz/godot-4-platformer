extends Area2D

export (String, FILE, "*.tscn") var target_level_path = ""

func _on_Door_body_entered(_body: Player) -> void:
	var _a = get_tree().change_scene(target_level_path)
