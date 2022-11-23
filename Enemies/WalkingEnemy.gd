extends KinematicBody2D

const max_speed = 25.0

var velocity = Vector2.ZERO
var direction = Vector2.RIGHT

onready var sprite = $AnimatedSprite
onready var ledge_check = $LedgeCheck

func _ready():
	sprite.play("walk")
	sprite.flip_h = direction.x > 0

func _physics_process(_delta):
	var found_wall = is_on_wall()
	if found_wall:
		reverse_direction()

	var _a = move_and_slide(direction * max_speed, Vector2.UP)

	var near_edge = not ledge_check.is_colliding()
	if near_edge:
		reverse_direction()

func reverse_direction():
	direction *= -1
	ledge_check.position.x *= -1
	sprite.flip_h = direction.x > 0