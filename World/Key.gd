extends Area2D

onready var player_stats = PlayerStats
onready var gaudio = GAudio

func _on_Key_body_entered(_body: Player) -> void:
	player_stats.keys += 1
	queue_free()
	gaudio.play_sound(gaudio.KeyCollected)
