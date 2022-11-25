extends Node2D

onready var ladder1 = $Ladder1
onready var audio = $AudioStreamPlayer

func _ready():
	VisualServer.set_default_clear_color(Color.skyblue)

	remove_child(ladder1)

func _on_SwitchForLadder1_switch_on_ladder1() -> void:
	call_deferred("add_child", ladder1)
	audio.play()