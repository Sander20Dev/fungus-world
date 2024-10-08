@tool

class_name Spring extends Node2D

@export_category("Time")
@export var delay: float = 0

@export_category("Function")
@export var disabled = true :
	set(val):
		disabled = val
		_toggle_disabled()

const SPRING = preload("res://assets/sprites/utilities/spring.png")
const SPRING_DISABLED = preload("res://assets/sprites/utilities/spring_disabled.png")

const SPRING_JUMP_SPEED = -1250

@onready var delay_timer: Timer = $Delay

var _current: Fungy

func _ready() -> void:
	if Engine.is_editor_hint(): return
	if not disabled and delay > 0:
		disabled = true
		delay_timer.wait_time = delay
		delay_timer.start()

func use_button():
	if delay > 0:
		disabled = true
		delay_timer.wait_time = delay
		delay_timer.start()
	else:
		disabled = false

func _toggle_disabled():
	$SpringBody/Spring.texture = SPRING_DISABLED if disabled else SPRING
	
	if disabled:
		$SpringBody/AnimationPlayer.play("RESET")

func _on_delay_timeout() -> void:
	disabled = false

func _jump():
	if not _current: return
	_current.velocity.y = SPRING_JUMP_SPEED

func _on_spring_detector_body_entered(body: Node2D) -> void:
	if disabled: return
	if body is Fungy:
		_current = body
		$SpringBody/AnimationPlayer.play("compression")


func _on_spring_detector_body_exited(body: Node2D) -> void:
	if body is Fungy:
		_current = null
