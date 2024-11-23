@tool

class_name Gate extends StaticBody2D

const GATE_SPRITE = preload("res://utilities/scape_options/gate_sprite.tscn")

@export var height: int = 1 :
	set(val):
		height = val
		if not $Sprites: return
		for child in $Sprites.get_children():
			if child is Sprite2D:
				child.queue_free()
		for i in range(height):
			_create_sprite(i, height)
		$CollisionShape2D.shape.size = Vector2(16, 64*height)

func _create_sprite(i: int, count: int):
	for j in range(4):
		var sprite = GATE_SPRITE.instantiate()
		if j == 0 and i == 0:
			sprite.frame = 0
		elif j == 3 and i == (count-1):
			sprite.frame = 3
		else:
			sprite.frame = 1
		sprite.position.y = i*64 + j*16 - count*32 + 8
		$Sprites.add_child(sprite)

func _ready():
	for child in $Sprites.get_children():
		if child is Sprite2D:
			child.queue_free()
	for i in range(height):
		_create_sprite(i, height)
	$CollisionShape2D.shape.size = Vector2(16, 64*height)

func use_button():
	var tween = create_tween()
	var last_pos = position
	tween.tween_property(self, "position", last_pos - Vector2(0, height*64), 1)
func button_disable():
	var tween = create_tween()
	var last_pos = position
	tween.tween_property(self, "position", last_pos + Vector2(0, height*64), 1)
