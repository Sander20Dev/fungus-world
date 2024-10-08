@tool

class_name VPlatform extends Node2D

const PLATFORM_MARKER = preload("res://utilities/platforms/platform_marker.tscn")
const PLATFORM_SPEED = 2
@export_category("Movement")
@export_range(-16, 0) var min_v: int = 0 :
	set(val):
		min_v = val
		print("min_v", val)
		_set_markers()
@export_range(0, 16) var max_v: int = 0 :
	set(val):
		max_v = val
		print("max_v", val)
		_set_markers()
@export_category("Time")
@export var delay: float = 0

@onready var markers: Node2D = $Markers
@onready var platform: StaticBody2D = $Platform
@onready var delay_timer: Timer = $Delay
@onready var engine_active: AudioStreamPlayer2D = $EngineActive

@export_category("Function")
@export var disabled = true :
	set(val):
		disabled = val
		if not disabled:
			_direction = 1
			if not Engine.is_editor_hint() and engine_active: engine_active.play()

var _last_pos = 0

var _current = 0
var _direction = 1

var _default_pos = 0

func _ready() -> void:
	if Engine.is_editor_hint(): return
	if not disabled and delay > 0:
			disabled = true
			delay_timer.wait_time = delay
			delay_timer.start()
		
	_default_pos = platform.position.y
	_set_markers()

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	if disabled and _current == 0: return
	
	_current += _direction * PLATFORM_SPEED * delta
	if _current > max_v:
		_direction = -1
		_current = max_v
	elif _current < min_v:
		_direction = 1
		_current = min_v
	if disabled:
		if _current == 0:
			_direction = 0
		if _last_pos < 0 and _current > 0:
			_current = 0
			_direction = 0
		if _last_pos > 0 and _current < 0:
			_current = 0
			_direction = 0
	platform.position.y = _default_pos + -_current*64
	_last_pos = _current

func _set_markers():
	if not markers: markers = $Markers
	if markers:
		for child in markers.get_children():
			child.queue_free()
		var count = max_v + 1 - min_v
		
		for i in range(count):
			var marker = PLATFORM_MARKER.instantiate()
			marker.position.y = -(min_v+i)*64
			markers.add_child(marker)

func use_button():
	if delay > 0:
		disabled = true
		delay_timer.wait_time = delay
		delay_timer.start()
	else:
		disabled = false


func _on_delay_timeout() -> void:
	disabled = false


func _on_engine_active_audio_finished() -> void:
	if disabled: return
	engine_active.play()
