@tool

class_name Level
extends Node2D

@export var player_spawn_node: Marker2D
var player_spawn: Vector2 :
	set(val):
		player_spawn_node.position = val
	get:
		return player_spawn_node.position
@export var world = 1 :
	set(val):
		world = val
		start()
		print(Levels.tiles_color)

@export var origin: Vector2
@export var size: Vector2

func start():
	var colorize = get_node_or_null("Colorize")
	if colorize and colorize is Node2D:
		(colorize as Node2D).modulate = Levels.tiles_color[world-1]
