extends Area2D

onready var shape = $Shape
onready var animsprite = $AnimatedSprite
onready var gevents = GEvents

func _ready() -> void:
	animsprite.play("inactive")

func _on_Checkpoint_body_entered(_body: Player) -> void:
	shape.set_deferred("disabled", true)
	animsprite.play("active")
	gevents.emit_hit_checkpoint(global_position)
	# TODO add sound