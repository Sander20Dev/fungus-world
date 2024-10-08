class_name InteractiveButton
extends Area2D

@onready var button: Sprite2D = $Button
@onready var button_pressed_sound: AudioStreamPlayer2D = $ButtonPressedSound

@export var interactuable_node: Node2D

var active = false

func _on_body_entered(body: Node2D) -> void:
	if not active and body is Fungy:
		button_pressed_sound.play()
		active = true
		button.frame = 1
		if interactuable_node and interactuable_node.has_method("use_button"):
			interactuable_node.use_button()
