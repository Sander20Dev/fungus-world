class_name LevelManager
extends Node2D

static var instance: LevelManager

@onready var fungy: Fungy = $"../Fungy"
@onready var main_camera: MainCamera = $"../MainCamera"
@onready var transition: TransitionLevel = $"../Transition"
@onready var track_1: AudioStreamPlayer = $"../Track1"

@export var world = 1
@export var level = 1

@export var all_levels: Array[PackedScene] = []

var current_level_node: Node2D
var _new_level: Node2D
var transition_loaded = false
var scene_loaded = false

func _ready():
	instance = self
	change_level(world, level)

func change_level(world: int, level: int) -> void:
	var index = (world-1) * 4 + (level-1)
	
	if all_levels.size() > index:
		_new_level = all_levels[index].instantiate()
		
		self.world = world
		self.level = level
		
		get_tree().paused = true
		track_1.process_mode = Node.PROCESS_MODE_ALWAYS
		transition.show()
		main_camera.position_smoothing_enabled = false
		
		if current_level_node:
			transition.transition_out()
		else:
			_load_new_level()

func reload_level():
	change_level(world, level)

func get_next_level():
	var lvl = level+1
	var wrld = world
	
	if lvl > 4:
		lvl = 1
		wrld += 1
	
	var index = (wrld-1) * 4 + (lvl-1)
	
	if all_levels.size() > index:
		return [wrld, lvl]
	else:
		return null

func can_go_to_next_level():
	return not not get_next_level()

func go_to_next_level():
	var data = get_next_level()
	
	if not data: return
	
	change_level(data[0], data[1])

func _load_new_level():
	current_level_node = _new_level
	
	transition.transition_in()
	add_child(current_level_node)
	if current_level_node is Level:
		fungy.position = current_level_node.player_spawn
		main_camera.origin_by_tiles = current_level_node.origin
		main_camera.size_by_tiles = current_level_node.size

func _on_transition_animation_end(anim_name: StringName) -> void:
	if anim_name == "out":
		if current_level_node:
			current_level_node.queue_free()
		_load_new_level()
	else:
		main_camera.position_smoothing_enabled = true
		transition.hide()
		track_1.process_mode = Node.PROCESS_MODE_INHERIT
		get_tree().paused = false
