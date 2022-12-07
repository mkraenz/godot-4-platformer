extends Area2D

export var text := ""
# using very small value instead of 0 because godot's timer does not like the 0.
export (float, 0.01, 10, 0.01) var wait_time_for_keyhint := 0.5

onready var gevents = GEvents
onready var keyhint = $Keyhint
onready var keyhint_timer = $KeyhintTimer

var on_player := false

func _on_Signpost_body_entered(_body: Player) -> void:
	on_player = true
	keyhint_timer.start(wait_time_for_keyhint)
	
func _on_Signpost_body_exited(_body: Player) -> void:
	on_player = false
	keyhint_timer.stop()
	keyhint.hide()

func _unhandled_input(_event: InputEvent) -> void:
	if on_player and Input.is_action_just_pressed("jump"):
		gevents.emit_display_message(text)
		
func _on_KeyhintTimer_timeout() -> void:
	keyhint.show()
