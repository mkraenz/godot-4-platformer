extends Node2D

const Player = preload("res://Player/Player.tscn")

onready var player = $Player
onready var cam = $Cam
onready var gevents = GEvents

var player_spawnpoint = Vector2.ZERO

func _ready():
	VisualServer.set_default_clear_color(Color.skyblue)

	gevents.connect("hit_checkpoint", self, "_on_hit_checkpoint")
	gevents.connect("player_died", self, "_on_player_died")

	player_spawnpoint = player.global_position
	connect_player(player)

func _on_player_died() -> void:
	yield(get_tree().create_timer(0.8), 'timeout')
	var new_player = Player.instance()
	add_child(new_player)
	connect_player(new_player)

func connect_player(player_: Player) -> void:
	player_.connect_camera(cam)
	player_.global_position = player_spawnpoint

func _on_hit_checkpoint(global_pos: Vector2):
	player_spawnpoint = global_pos