extends HBoxContainer

const KeyIcon = preload("res://UI/KeyIcon.tscn")

func set_keys(amount: int):
	print(amount)
	var child_count = get_children().size()
	if child_count == amount:
		return
	if child_count < amount:
		for _i in range(0, amount - child_count):
			var key = KeyIcon.instance()
			add_child(key)
	else:
		for i in range(0, child_count - amount):
			get_child(i).queue_free()