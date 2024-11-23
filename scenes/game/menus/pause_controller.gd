extends Node
@onready var pause_menu: PauseLayer = $".."

func _input(ev: InputEvent) -> void:
	if ev is InputEventKey and ev.is_action_pressed("pause"):
		if pause_menu.is_paused:
			pause_menu.hide_pause()
		else:
			if not LevelManager.instance.is_changing:
				pause_menu.show_pause()
