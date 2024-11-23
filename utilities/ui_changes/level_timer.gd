class_name LevelTimer extends CanvasLayer

@onready var timer: Timer = $Timer
@onready var mins: Label = $PanelContainer/MarginContainer/HBoxContainer/Mins
@onready var secs: Label = $PanelContainer/MarginContainer/HBoxContainer/Secs

@export var time_duration = 60

func _ready() -> void:
	$PanelContainer.modulate = Global.get_tint_color(Global.world)
	$ColorRect.color = Global.get_bg_color(Global.world)
	timer.wait_time = time_duration
	timer.start()

func _process(delta: float) -> void:
	var m = floori(timer.time_left / 60)
	var s = floori(timer.time_left) % 60
	
	var m_txt = str(m)
	var s_txt = str(s)
	if m < 10:
		m_txt = "0" + m_txt
	if s < 10:
		s_txt = "0" + s_txt
	
	mins.text = m_txt
	secs.text = s_txt


func _on_timer_timeout() -> void:
	if LevelManager.instance: LevelManager.instance.current_level_states.kill()
