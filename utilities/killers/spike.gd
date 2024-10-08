@tool

extends StaticBody2D

@onready var killer: Area2D = $Killer

enum ROTATION {
	TOP,
	LEFT,
	RIGHT,
	BOTTOM
}

@export var rotated = ROTATION.TOP :
	set(val):
		rotated = val
		if val == ROTATION.TOP:
			rotation_degrees = 0
		elif val == ROTATION.BOTTOM:
			rotation_degrees = 180
		elif val == ROTATION.LEFT:
			rotation_degrees = 90
		elif val == ROTATION.RIGHT:
			rotation_degrees = 270

func _ready() -> void:
	killer.body_entered.connect(_detect_collision)

func _detect_collision(body: Node2D):
	if not LevelManager.instance: return
	if Engine.is_editor_hint(): return
	if LevelManager.instance.current_level_states.is_dead: return
	
	if body is Fungy:
		LevelManager.instance.current_level_states.kill()
