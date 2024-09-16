class_name Door
extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var scene_after_to_win: PackedScene
const WIN_SCREEN = "res://views/win_screen.tscn"

var is_door_open = false

func _process(delta: float):
	if Global.players.filter(func(p): return p is Fungy).all(func(p): return p.escaped):
		if scene_after_to_win:
			get_tree().change_scene_to_packed(scene_after_to_win)
		else: get_tree().change_scene_to_file(WIN_SCREEN)

func open_the_door():
	is_door_open = true
	sprite_2d.frame = 1

	for player in Global.players:
		if player is Fungy:
			player.allow_exit()
