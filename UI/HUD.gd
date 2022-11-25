extends Control

onready var anims = $Anims
onready var player_stats := PlayerStats

func _ready():
	var _a = player_stats.connect("max_health_changed", self, "_on_max_health_changed")
	var _b = player_stats.connect("health_changed", self, "_on_health_changed")
	var _c = player_stats.connect("no_health", self, "_on_no_health")

func _on_max_health_changed(data: Dictionary):
	var _diff = data["diff"]
	# TODO
	
func _on_health_changed(data: Dictionary):
	var diff = data['diff']
	if diff < 0:
		anims.play("hurt_sfx")

func _on_no_health():
	pass # TODO