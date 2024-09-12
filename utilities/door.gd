class_name Door
extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
const WIN_SCREEN = "res://views/win_screen.tscn"

var is_door_open = false

func _process(delta: float):
	if Global.players.filter(func(p): return p is FungyRed).all(func(p): return p.escaped):
		get_tree().change_scene_to_file(WIN_SCREEN)

func open_the_door():
	is_door_open = true
	sprite_2d.frame = 1

	for player in Global.players:
		if player is FungyRed:
			player.can_exit()
