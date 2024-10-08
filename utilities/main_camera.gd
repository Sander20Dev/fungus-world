@tool

class_name MainCamera
extends Camera2D

@export_category("Camera Position")
@export var node_to_follow: Node2D
@export var origin_by_tiles = Vector2() :
	set(val):
		origin_by_tiles = val
		limit_top = origin_by_tiles.y * 64
		limit_left = origin_by_tiles.x * 64
		_update_sizes()

@export var size_by_tiles = Vector2(12, 18) :
	set(val):
		size_by_tiles = val
		_update_sizes()
		

func _ready():
	if node_to_follow:
		position = node_to_follow.position

func _process(delta: float) -> void:
	if node_to_follow:
		position = node_to_follow.position

func _update_sizes():
	if size_by_tiles.x == 0:
		limit_right = 999999
	else:
		limit_right = origin_by_tiles.x * 64 + size_by_tiles.x * 64
	if size_by_tiles.y == 0:
		limit_bottom = 999999
	else:
		limit_bottom = origin_by_tiles.y * 64 + size_by_tiles.y * 64
