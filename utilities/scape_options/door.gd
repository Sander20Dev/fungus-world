class_name Door
extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var scene_after_to_win: PackedScene
@onready var door_opening: AudioStreamPlayer2D = $DoorOpening

const WIN_SCREEN = "res://views/win_screen.tscn"

var is_door_open = false

func _process(delta: float):
	var players = Global.players.filter(func(p): return p is Fungy)

	if players.all(func(p): return p.escaped):
		if scene_after_to_win:
			get_tree().change_scene_to_packed(scene_after_to_win)
		else:
			if LevelManager.instance.can_go_to_next_level():
				LevelManager.instance.go_to_next_level()
			else:
				get_tree().change_scene_to_file(WIN_SCREEN)
	for p in players:
		p.reset()

func open_the_door():
	if not is_door_open:
		door_opening.play()
	
	is_door_open = true
	sprite_2d.frame = 1

	for player in Global.players:
		if player is Fungy:
			player.allow_exit()
