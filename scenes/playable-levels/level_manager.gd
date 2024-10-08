class_name LevelManager
extends Node2D

static var instance: LevelManager

@onready var fungy: Fungy = $"../Fungy"
@onready var main_camera: MainCamera = $"../MainCamera"
@onready var transition: TransitionLevel = $"../Transition"
@onready var track_1: AudioStreamPlayer = $"../Track1"
@onready var mobile_controls: CanvasLayer = $"../MobileControls"

@export var all_levels: Array[PackedScene] = []

var current_level_node: Node2D
var _new_level: Node2D
var transition_loaded = false
var scene_loaded = false

var is_changing = false

var current_level_states = LevelState.new()

#@onready var environment = Environment.new()
#@onready var world2d = get_world_2d()

func _ready():
	if not Global.is_mobil: mobile_controls.hide()
	
	instance = self
	change_level(Global.world, Global.level)

func change_level(world: int, level: int) -> void:
	if is_changing: return
	
	var index = (world-1) * 4 + (level-1)
	is_changing = true
	
	#if all_levels.size() > index:
	if Global.last_world >= world and world > 0 and level > 0 and level < 5:
		fungy.do_untangible()
		#_new_level = all_levels[index].instantiate()
		_new_level = get_level(world, level).instantiate()
		print("instantiated: ", world, "-", level)
		Levels.currentRawWorld = world-1
		
		Global.world = world
		Global.level = level
		
		transition.show()
		main_camera.position_smoothing_enabled = false
		
		if current_level_node:
			transition.transition_out()
		else:
			Global.update_color()
			_load_new_level()

func reload_level():
	change_level(Global.world, Global.level)

func get_next_level():
	var lvl = Global.level+1
	var wrld = Global.world
	
	if lvl > 4:
		lvl = 1
		wrld += 1
	
	var index = (wrld-1) * 4 + (lvl-1)
	
	if Global.last_world >= wrld:
		return [wrld, lvl]
	else:
		return null

func get_level(world: int, level: int):
	var level_packed = load("res://scenes/playable-levels/world"+str(world)+"/lvl "+str(level)+".tscn")
	if level_packed is PackedScene:
		return level_packed
	return null

func can_go_to_next_level():
	return not not get_next_level()

func go_to_next_level():
	var data = get_next_level()
	
	if not data: return
	
	change_level(data[0], data[1])

func _load_new_level():
	current_level_node = _new_level
	
	add_child(current_level_node)
	transition.transition_in()
	if current_level_node is Level:
		fungy.position = current_level_node.player_spawn
		main_camera.origin_by_tiles = current_level_node.origin
		main_camera.size_by_tiles = current_level_node.size
		current_level_node.start()

func _end_transition():
	main_camera.position_smoothing_enabled = true
	transition.hide()
	current_level_states = LevelState.new()
	is_changing = false
	fungy.do_tangible()

func _on_transition_animation_end(anim_name: StringName) -> void:
	if anim_name == "out":
		if current_level_node:
			current_level_node.queue_free()
		Global.update_color()
		_load_new_level()
	else:
		_end_transition()

func _process(_delta):
	if is_changing: return
	
	#print($"../PauseMenu".is_paused)
	if Input.is_action_just_pressed("pause") and not $"../PauseMenu".is_paused:
		$"../PauseMenu".show_pause()
