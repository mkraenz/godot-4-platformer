extends Area2D

func _on_Hitbox_body_entered(body: Player):
	body.die()
