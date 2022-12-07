extends Control

export var text_speed := 0.05

onready var text := $M/Background/M/V/H/Text
onready var tween := $Tween
onready var gevents := GEvents

var current_message := ""
var finished := true

func _ready() -> void:
	var _a = gevents.connect("display_message", self, "_on_display_message")
	hide()

func _unhandled_input(_event: InputEvent) -> void:
	if finished and Input.is_action_just_pressed("ui_accept"):
		hide()
	if not finished and Input.is_action_just_pressed("ui_accept"):
		skip_message()

func display_message(message: String) -> void:
	current_message = message
	finished = false
	text.bbcode_text = current_message
	var _a = tween.interpolate_property(
		text, "visible_characters", 0, len(current_message), text_speed * len(current_message),\
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
	tween.start()
	show()

func skip_message():
	tween.stop(text, "visible_characters")
	text.visible_characters = len(current_message)
	finished = true

func _on_display_message(message: String) -> void:
	display_message(message)

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	# reset values
	finished = true
	current_message = ""
