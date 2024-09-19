class_name InteractiveButton
extends Area2D

@onready var button: Sprite2D = $Button

@export var node: Node2D

var active = false

func _on_body_entered(body: Node2D) -> void:
	if not active and body is Fungy:
		active = true
		button.frame = 1
		if node and node.has_method("use_button"):
			node.use_button()
