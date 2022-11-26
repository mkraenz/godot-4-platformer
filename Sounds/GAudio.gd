extends Node

const KeyCollected = preload("res://Sounds/key-collected.mp3")
const KeyUsed = preload("res://Sounds/key-collected.mp3") # TODO change sound file

func play_sound(sound):
	for player in get_children():
		if not player.playing:
			player.stream = sound
			player.play()
			return