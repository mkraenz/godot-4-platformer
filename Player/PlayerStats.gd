extends "res://Common/Stats.gd"

func _ready() -> void:
    health = 3
    max_health = 3

func reset_singleton():
    # intentionally not triggering setters to avoid triggering callbacks
    max_health = 3
    health = 3