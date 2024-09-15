extends Area2D

const SIZE_SPEED = Vector2(1,1)

@onready var sprite: Sprite2D = $Sprite2D

enum KIND_OF_SCALE {
	ASC,
	DESC
}

@export var min_scale = 0.5
@export var max_scale = 4.5
@export var kind_of_scale: KIND_OF_SCALE = KIND_OF_SCALE.ASC

var array: Array[Fungy] = []

func _physics_process(delta: float) -> void:
	sprite.frame = 0 if array.is_empty() else 1
	
	for player in array:
		player.scale += SIZE_SPEED * delta * (1 if kind_of_scale == KIND_OF_SCALE.ASC else -1)
		if player.scale.x > max_scale or player.scale.y > max_scale:
			player.scale = Vector2(max_scale, max_scale)
		if player.scale.x < min_scale or player.scale.y < min_scale:
			player.scale = Vector2(min_scale, min_scale)

func _on_body_entered(body: Node2D) -> void:
	array.push_front(body)


func _on_body_exited(body: Node2D) -> void:
	if (body is Fungy) and array.has(body):
		array.remove_at(array.find(body))
