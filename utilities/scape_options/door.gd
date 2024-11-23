class_name Door
extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var scene_after_to_win: PackedScene
@onready var door_opening: AudioStreamPlayer2D = $DoorOpening

const WIN_SCREEN = "res://views/win_screen.tscn"

var is_door_open = false

var fungy: Fungy

func _ready() -> void:
	body_entered.connect(func (p): fungy = p)
	body_exited.connect(func (p): fungy = null)

func _process(delta: float):
	LevelManager.instance.can_player_interact = false
	
	if not fungy: return
	
	if not is_door_open:
		if fungy.item == Global.ITEMS_NAME.KEY:
			LevelManager.instance.can_player_interact = true
			if Input.is_action_just_pressed("p1_interact"):
				open_the_door()
	else:
		if Input.is_action_just_pressed("p1_sneak"):
			if scene_after_to_win: get_tree().change_scene_to_packed(scene_after_to_win)
			else:
				if LevelManager.instance and LevelManager.instance.can_go_to_next_level():
						LevelManager.instance.go_to_next_level()
				else:
					get_tree().change_scene_to_file("res://views/win_screen.tscn")
	pass

# TODO: MAKE E TO INTERACT
func open_the_door():
	fungy.collect_item(null)
	door_opening.play()
	is_door_open = true
	sprite_2d.frame = 1
