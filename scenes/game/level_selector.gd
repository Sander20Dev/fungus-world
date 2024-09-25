class_name LevelSelector extends CanvasLayer

const GAME = preload("res://scenes/playable-levels/game.tscn")
@onready var level_1: TextureButton = $"Colorize/MarginContainer/HBoxContainer/Level 1"
@onready var level_2: TextureButton = $"Colorize/MarginContainer/HBoxContainer/Level 2"
@onready var level_3: TextureButton = $"Colorize/MarginContainer/HBoxContainer/Level 3"
@onready var level_4: TextureButton = $"Colorize/MarginContainer/HBoxContainer/Level 4"
@onready var colorize: Control = $Colorize
@onready var title: Label = $Colorize/Title
#@onready var go_to_back: TextureButton = $Colorize/GoToBack

func _ready():
	level_1.pressed.connect(_go_to_level(1))
	level_2.pressed.connect(_go_to_level(2))
	level_3.pressed.connect(_go_to_level(3))
	level_4.pressed.connect(_go_to_level(4))
	
	colorize.modulate = Global.get_tint_color(Global.world)
	title.text = str(Global.world) + ". " + tr("WORLD_"+str(Global.world)+".NAME")

func _go_to_level(level: int):
	return func():
		Global.level = level
		get_tree().change_scene_to_packed(GAME)
