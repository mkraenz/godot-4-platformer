extends Control

export (PackedScene) var level

onready var buttons = $Buttons
onready var continue_button = $Buttons/ContinueButton
onready var new_game_button = $Buttons/NewGameButton
onready var quit_button = $Buttons/QuitButton

var selectable_buttons := []
var selected_index := 0 # the index within selectable_buttons of the currently selected/focused button

func _ready() -> void:
	selectable_buttons = filter_enabled_buttons(buttons.get_children()) 
	update_selected_button()

func filter_enabled_buttons(given_buttons: Array) -> Array:
	var enabled_buttons := []
	for b in given_buttons:
		if not b.disabled:
			enabled_buttons.append(b)
	return enabled_buttons

func _unhandled_input(_event: InputEvent):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().set_input_as_handled() # stop event propagation
		selectable_buttons[selected_index].act() # each custom button implements act()
	
	var input_y = Input.get_axis("jump", "move_down")
	selected_index = posmod(selected_index + int(input_y), len(selectable_buttons)) 
	update_selected_button()

func update_selected_button() -> void:
	selectable_buttons[selected_index].grab_focus()

func _on_ContinueButton_mouse_entered() -> void:
	var index = selectable_buttons.find(continue_button)
	set_selected_button(index)

func _on_NewGameButton_mouse_entered() -> void:
	var index = selectable_buttons.find(new_game_button)
	set_selected_button(index)

func _on_QuitButton_mouse_entered() -> void:
	var index = selectable_buttons.find(quit_button)
	set_selected_button(index)
	
func set_selected_button(index: int):
	if index != -1:
		selected_index = index
	update_selected_button()
