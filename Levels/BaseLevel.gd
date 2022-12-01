extends Node2D

const Player = preload("res://Player/Player.tscn")

export var id: String

onready var player = $Player
onready var cam = $Cam
onready var gevents = GEvents
onready var player_stats = PlayerStats

var player_spawnpoint = Vector2.ZERO

func _ready():
	assert(id, "Missing id")

	gevents.connect("hit_checkpoint", self, "_on_hit_checkpoint")
	gevents.connect("player_died", self, "_on_player_died")
	gevents.connect("player_fell_down", self, "_on_player_fell_down")

	player_spawnpoint = player.global_position
	player_stats.level_path = get_filename()
	connect_player(player)

func _on_player_died() -> void:
	yield(get_tree().create_timer(0.8), 'timeout')
	var new_player = Player.instance()
	add_child(new_player)
	connect_player(new_player)
	player_stats.reset_singleton()
	
func _on_player_fell_down() -> void:
	yield(get_tree().create_timer(0.8), 'timeout')
	var new_player = Player.instance()
	add_child(new_player)
	connect_player(new_player)


func connect_player(player_: Player) -> void:
	player_.connect_camera(cam)
	player_.global_position = player_spawnpoint

func _on_hit_checkpoint(global_pos: Vector2):
	player_spawnpoint = global_pos
