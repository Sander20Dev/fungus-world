@tool

class_name Lazer
extends Node2D

const LAZER = preload("res://utilities/killers/lazer/raw_lazer.tscn")

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
		for lazer in _get_all_lazers():
			lazer.disabled = val

func _ready() -> void:
	for lazer in _get_all_lazers():
		if lazer is RawLazer:
			lazer.setup()

func _get_all_lazers():
	return get_children().filter(func (l): return l is RawLazer) as Array[RawLazer]
