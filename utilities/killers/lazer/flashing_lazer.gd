@tool
class_name FlashingLazer extends Lazer

@onready var timer: Timer = $Timer

@export var time: float = 1 :
	set(val):
		time = val
		$Timer.wait_time = val

var is_active = true :
	set(val):
		is_active = val
		disabled = !val

func _ready():
	if Engine.is_editor_hint(): return
	timer.wait_time = time
	timer.start()
	super._ready()

func _on_timer_timeout() -> void:
	if Engine.is_editor_hint(): return
	is_active = not is_active
	timer.start()
