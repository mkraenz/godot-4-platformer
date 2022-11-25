extends "res://Common/Stats.gd"

func _ready() -> void:
    health = 3
    max_health = 3

# autoload vars arent actually singletons but for us they are _by convention_
func reset_singleton():
    # trigger setters so that HUD updates
    self.max_health = 3
    self.health = 3