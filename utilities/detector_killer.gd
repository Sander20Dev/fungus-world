extends Node2D

func _process(delta: float) -> void:
	for player in Global.players.filter(func (p): return p is Fungy):
		if player.position.y >= position.y:
			get_tree().reload_current_scene()
