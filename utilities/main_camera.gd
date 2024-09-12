class_name MainCamera
extends Camera2D

@export_category("Camera Position")
@export var node_to_follow: Node2D
@export var count_of_tiles = Vector2()

func _ready():
	limit_left = 0
	limit_top = 0

func _process(delta: float) -> void:
	position = node_to_follow.position
	limit_right = count_of_tiles.x * 32
	limit_bottom = count_of_tiles.y * 32
