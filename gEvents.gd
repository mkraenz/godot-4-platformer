extends Node

# autoloaded / global var that acts as a message bus for sending messages to the world from anywhere using specific function calls.

signal player_fell_down # i.e. below bottom of the level
signal player_died
# theres no way to type signals yet, so use the emit functions from the children.
# gh issue https://github.com/godotengine/godot-proposals/issues/2557
signal hit_checkpoint(global_position)

func emit_player_died():
	emit_signal("player_died")

func emit_hit_checkpoint(global_pos: Vector2):
	emit_signal("hit_checkpoint", global_pos)

func emit_player_fell_down():
	emit_signal("player_fell_down")