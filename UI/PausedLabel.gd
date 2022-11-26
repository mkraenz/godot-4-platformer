extends Label

func _ready() -> void:
	visible = true

func _on_VisibilityTimer_timeout() -> void:
	visible = not visible
