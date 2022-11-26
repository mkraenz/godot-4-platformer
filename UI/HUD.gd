extends Control

onready var anims = $Anims
onready var player_stats := PlayerStats
onready var full_hearts := $FullHearts
onready var empty_hearts := $EmptyHearts
onready var keys := $Keys

func _ready():
	var _a = player_stats.connect("max_health_changed", self, "_on_max_health_changed")
	var _b = player_stats.connect("health_changed", self, "_on_health_changed")
	var _c = player_stats.connect("no_health", self, "_on_no_health")
	var _d = player_stats.connect("keys_changed", self, "_on_keys_changed")

	update_hearts()
	update_keys()

func _on_max_health_changed(data: Dictionary):
	var _diff = data["diff"]
	update_hearts()
	
func _on_health_changed(data: Dictionary):
	update_hearts()
	var diff = data['diff']
	if diff < 0:
		anims.play("hurt_sfx")

func update_hearts():
	empty_hearts.set_hearts(player_stats.max_health)
	full_hearts.set_hearts(player_stats.health)

func _on_no_health():
	pass # TODO

func _on_keys_changed(_data: Dictionary):
	update_keys()

func update_keys():
	keys.set_keys(player_stats.keys)
