extends Button


func _ready() -> void:
	pass

func act() -> void:
	get_tree().quit()

func _on_QuitButton_pressed() -> void:
	act()
