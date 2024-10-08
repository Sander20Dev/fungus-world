@tool

class_name Lazer
extends Node2D

const LAZER = preload("res://utilities/killers/lazer/raw_lazer.tscn")
@onready var lazer_off_sound: AudioStreamPlayer2D = $LazerOffSound
@onready var lazer_on_sound: AudioStreamPlayer2D = $LazerOnSound

@export var lazers_count: int = 1 :
	set(val):
		lazers_count = val
		for lazer in _get_all_lazers():
			lazer.queue_free()
		if lazers_count < 1: return
		
		var val_range = range(val)
		var middle = (float(val_range.size()) - 1)/2
		for i in val_range:
			var lazer = LAZER.instantiate()
			add_child(lazer)
			lazer.position.y = (i-middle) * 64

var disabled = false :
	set(val):
		disabled = val
		if lazer_off_sound and val:
			lazer_off_sound.play()
		if lazer_on_sound and not val:
			lazer_on_sound.play()
		for lazer in _get_all_lazers():
			lazer.disabled = val

func _ready() -> void:
	if not lazer_off_sound: lazer_off_sound = $LazerOffSound
	if not lazer_on_sound: lazer_on_sound = $LazerOnSound
	for lazer in _get_all_lazers():
		if lazer is RawLazer:
			lazer.setup()

func _get_all_lazers():
	return get_children().filter(func (l): return l is RawLazer) as Array[RawLazer]
