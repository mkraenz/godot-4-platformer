extends Camera2D

var speed = 15

func _process(delta: float) -> void:
	position.x += speed * delta
