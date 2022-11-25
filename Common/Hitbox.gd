extends Area2D

export var damage := 1

func _on_Hitbox_body_entered(body: Player):
	body.take_damage(damage)
