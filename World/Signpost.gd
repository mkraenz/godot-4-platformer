extends Area2D

export var text := "Use WASD to move. W to interact."

onready var gevents = GEvents
onready var keyhint = $WKey

var on_player := false

func _on_Signpost_body_entered(_body: Player) -> void:
    on_player = true
    keyhint.show()

func _on_Signpost_body_exited(_body: Player) -> void:
    on_player = false
    keyhint.hide()

func _unhandled_input(_event: InputEvent) -> void:
    if on_player and Input.is_action_just_pressed("jump"):
        gevents.emit_display_message(text)