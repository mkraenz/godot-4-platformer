extends KinematicBody2D

const max_speed = 25.0

var velocity = Vector2.ZERO
var direction = Vector2.RIGHT

onready var sprite = $AnimatedSprite

func _ready():
	sprite.play("walk")

func _physics_process(_delta):
	var found_wall = is_on_wall()
	if found_wall:
		direction *= -1

	velocity = direction * max_speed
	velocity = move_and_slide(velocity, Vector2.UP)

	sprite.flip_h = direction.x > 0