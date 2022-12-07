extends Polygon2D

onready var tween = $Tween
const anim_duration = 1

func _ready():
	var _a = tween.interpolate_property(
		self, "position", Vector2(position.x, 0), Vector2(position.x, -100), anim_duration, Tween.TRANS_CIRC, Tween.EASE_IN_OUT
	)
	var _b = tween.start()
