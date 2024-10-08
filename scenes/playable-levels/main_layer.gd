class_name MainLayerGame extends CanvasLayer

func _on_pause() -> void:
	var pause: PauseLayer = $"../PauseMenu"
	if pause:
		pause.show_pause()
