extends Area2D

# absolute path to the object that gets activated by the switch
export var effect_node_path := "/root/Playground/Interactables/Ladder1"

onready var sprite = $AnimatedSprite
onready var audio = $AudioStreamPlayer

var effect_node: Node = null
var parent: Node = null

enum State {
	On,
	Off
}
var state = State.Off

func _ready() -> void:
	deactivate_effect()

func _on_Switch_body_entered(_body: Player) -> void:
	if state == State.Off:
		state = State.On
		sprite.play("on")
		audio.play()
		active_effect()

func active_effect() -> void:
	parent.call_deferred("add_child", effect_node)

func deactivate_effect() -> void:
	effect_node = get_node(effect_node_path)
	parent = effect_node.get_parent()
	parent.remove_child(effect_node)
