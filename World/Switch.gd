extends Area2D

signal switch_on_ladder1

onready var sprite = $AnimatedSprite

func _on_Switch_body_entered(_body: Player) -> void:
	sprite.play("on")
	emit_signal("switch_on_ladder1")
