tool
extends Area2D

export (float) var width = 20.0 setget set_width
export (float) var height = 100.0 setget set_height

onready var detection_shape = $DetectionShape

var player: Player = null

func set_width(val):
	width = val
	update_rect()

func set_height(val):
	height = val
	update_rect()

func set_rotation(val):
	rotation = val
	update_rect()


func update_rect():
	if detection_shape:
		detection_shape.shape.extents = Vector2(width, height)
		detection_shape.position.y = height


func _on_DetectionArea_body_exited(_body: Player) -> void:
	player = null
	
func _on_DetectionArea_body_entered(body: Player) -> void:
	player = body

