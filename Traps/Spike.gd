extends Area2D

const damage = 2

func _on_Spike_body_entered(body: Player):
	body.take_damage(damage)