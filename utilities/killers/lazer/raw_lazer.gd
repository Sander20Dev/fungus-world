class_name RawLazer
extends Area2D

var disabled = false

func setup():
	var animated: AnimatedSprite2D = $AnimatedSprite2D
	animated.play("default")


func _process(_delta):
	if Engine.is_editor_hint(): return
	if not LevelManager.instance: return
	if LevelManager.instance.current_level_states.is_dead: return
	
	if disabled:
		hide()
	else:
		show()
		
		for body in get_overlapping_bodies():
			if body is Fungy:
				LevelManager.instance.current_level_states.kill()
	
