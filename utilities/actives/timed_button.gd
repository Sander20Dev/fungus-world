class_name TimedButton
extends Area2D

@onready var button: Sprite2D = $TimedButton
@onready var button_pressed_sound: AudioStreamPlayer2D = $ButtonPressedSound
@onready var time_label: Label = $TimeLabel
@onready var timer: Timer = $Timer

@export var interactuable_node: Node2D
@export var active_time: int = 1

var active = false

func _process(delta: float):
	time_label.text = str(ceili(timer.time_left)) + " s"

func _on_timer_timeout() -> void:
	active = false
	time_label.hide()
	button.frame = 0
	if interactuable_node and interactuable_node.has_method("button_disable"):
		interactuable_node.button_disable()


func _on_body_entered(body: Node2D) -> void:
	if not active and body is Fungy:
		button_pressed_sound.play()
		active = true
		time_label.show()
		time_label.rotation_degrees = -rotation_degrees
		button.frame = 1
		
		timer.wait_time = active_time
		timer.start()
		
		if interactuable_node and interactuable_node.has_method("use_button"):
			interactuable_node.use_button()
