@tool
class_name FlashingLazer extends Lazer

@onready var timer: Timer = $Timer
@onready var delay_timer: Timer = $Delay

@export var time: float = 1 :
	set(val):
		time = val
		$Timer.wait_time = val

@export var delay_time: float = 0 :
	set(val):
		delay_time = val
		if delay_time > 0:
			$Delay.wait_time = val

var is_active = true :
	set(val):
		is_active = val
		disabled = !val

func _ready():
	if Engine.is_editor_hint(): return
	if delay_time == 0:
		print("init")
		timer.wait_time = time
		timer.start()
	else:
		print("delay")
		is_active = false
		delay_timer.wait_time = delay_time
		delay_timer.start()
	super._ready()

func _on_timer_timeout() -> void:
	if Engine.is_editor_hint(): return
	is_active = not is_active
	timer.start()


func _on_delay_timeout() -> void:
	if Engine.is_editor_hint(): return
	print("init")
	is_active = true
	timer.wait_time = time
	timer.start()
