class_name LevelSelector extends CanvasLayer

const GAME = preload("res://scenes/playable-levels/game.tscn")
@onready var margin_container: MarginContainer = $MarginContainer
@onready var level_1: TextureButton = $"MarginContainer/HBoxContainer/Level 1"
@onready var level_2: TextureButton = $"MarginContainer/HBoxContainer/Level 2"
@onready var level_3: TextureButton = $"MarginContainer/HBoxContainer/Level 3"
@onready var level_4: TextureButton = $"MarginContainer/HBoxContainer/Level 4"

func _ready():
	level_1.pressed.connect(_go_to_level(1))
	level_2.pressed.connect(_go_to_level(2))
	level_3.pressed.connect(_go_to_level(3))
	level_4.pressed.connect(_go_to_level(4))
	
	margin_container.modulate = Levels.tiles_color[Global.world - 1]

func _go_to_level(level: int):
	return func():
		Global.level = level
		get_tree().change_scene_to_packed(GAME)
