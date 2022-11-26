extends "res://Common/Stats.gd"

signal keys_changed

var keys := 0 setget set_keys

func _ready() -> void:
    health = 3
    max_health = 3

# autoload vars arent actually singletons but for us they are _by convention_
func reset_singleton():
    # trigger setters so that HUD updates
    self.max_health = 3
    self.health = 3
    # dont reset keys

func set_keys(value: int):
    var prev = keys
    keys = value
    emit_signal("keys_changed", { "diff": keys - prev })
