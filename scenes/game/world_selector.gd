class_name WorldSelector extends CanvasLayer

const LEVEL_SELECTOR = preload("res://scenes/game/level_selector.tscn")
@onready var world_1: TextureButton = $"MarginContainer/GridContainer/World 1"
@onready var world_2: TextureButton = $"MarginContainer/GridContainer/World 2"
@onready var world_3: TextureButton = $"MarginContainer/GridContainer/World 3"
#@onready var world_4: TextureButton = $"MarginContainer/GridContainer/World 4"
#@onready var world_5: TextureButton = $"MarginContainer/GridContainer/World 5"
#@onready var world_6: TextureButton = $"MarginContainer/GridContainer/World 6"

func _ready():
	world_1.pressed.connect(_go_to_world(1))
	world_2.pressed.connect(_go_to_world(2))
	world_3.pressed.connect(_go_to_world(3))
	#world_4.pressed.connect(_go_to_world(4))
	#world_5.pressed.connect(_go_to_world(5))
	#world_6.pressed.connect(_go_to_world(6))

func _go_to_world(world: int):
	return func():
		Global.world = world
		get_tree().change_scene_to_packed(LEVEL_SELECTOR)
		Global.update_color()
