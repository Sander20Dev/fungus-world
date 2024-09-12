class_name Key
extends Area2D

@export var door: Door
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("idle")


func _on_body_entered(body: Node2D) -> void:
	if not door: return
	door.open_the_door()
	queue_free()
