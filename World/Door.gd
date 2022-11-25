extends StaticBody2D

onready var player_stats = PlayerStats

func open_door():
	player_stats.keys -= 1
	queue_free()
	# TODO play sound

func _on_ActionArea_body_entered(_body: Player) -> void:
	var can_open = player_stats.keys > 0
	if can_open:
		open_door()
