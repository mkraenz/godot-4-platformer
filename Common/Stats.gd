extends Node

signal max_health_changed
signal health_changed
signal no_health

export var max_health := 1 setget set_max_health
export var health := 1 setget set_health

func set_max_health(val: int) -> void:
	var prev = max_health
	max_health = max(val, 0) as int
	emit_signal("max_health_changed", {"diff": max_health - prev })

func set_health(val: int) -> void:
	var is_unchanged = val == health
	if is_unchanged:
		return
	var prev = health
	health = min(val, max_health) as int
	emit_signal("health_changed", {"diff": health - prev})
	if health <= 0:
		emit_signal("no_health")
