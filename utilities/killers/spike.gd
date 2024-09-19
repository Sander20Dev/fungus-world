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

func _process(_delta):
	if not LevelManager.instance: return
	if Engine.is_editor_hint(): return
	if LevelManager.instance.current_level_states.is_dead: return
	
	for body in killer.get_overlapping_bodies():
		if body is Fungy:
			LevelManager.instance.current_level_states.kill()
