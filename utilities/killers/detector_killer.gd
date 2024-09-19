extends Node2D

func _process(delta: float) -> void:
	for player in Global.players.filter(func (p): return p is Fungy):
		if player.position.y >= position.y:
			LevelManager.instance.current_level_states.kill()
