class_name MainLayerGame extends CanvasLayer

@onready var interact: RichTextLabel = $Interact

func _on_pause() -> void:
	var pause: PauseLayer = $"../PauseMenu"
	if pause:
		pause.show_pause()

func _process(delta: float) -> void:
	if not LevelManager.instance: return
	if LevelManager.instance.can_player_interact: interact.show()
	else: interact.hide()
