class_name LevelState extends Resource

var is_dead = false

func kill():
	if is_dead: return
	is_dead = true
	LevelManager.instance.reload_level()
