extends Area2D

signal switch_on_ladder1

onready var sprite = $AnimatedSprite

enum State {
	On,
	Off
}
var state = State.Off

func _on_Switch_body_entered(_body: Player) -> void:
	if state == State.Off:
		state = State.On
		sprite.play("on")
		emit_signal("switch_on_ladder1")
