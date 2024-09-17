class_name Level
extends Node2D

@export var player_spawn_node: Marker2D
var player_spawn: Vector2 :
	set(val):
		player_spawn_node.position = val
	get:
		return player_spawn_node.position
@export var world = 1
@export var level = 1

@export var origin: Vector2
@export var size: Vector2
