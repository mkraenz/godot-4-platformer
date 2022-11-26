extends Area2D

export (String, FILE, "*.tscn") var target_level_path = ""

onready var transitions := Transitions

func _on_Door_body_entered(_body: Player) -> void:
	print('on door body entered')
	get_tree().paused = true
	transitions.play_exit_transition()
	yield(transitions, "transition_finished")
	transitions.play_enter_transition()
	get_tree().paused = false
	var _a = get_tree().change_scene(target_level_path)

