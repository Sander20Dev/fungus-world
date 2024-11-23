class_name PauseLayer extends CanvasLayer

@onready var canvas_modulate: CanvasModulate = $CanvasModulate

var is_paused = false

func show_pause():
	is_paused = true
	get_tree().paused = true
	canvas_modulate.color = Global.get_tint_color(Global.world)
	show()
func hide_pause():
	is_paused = false
	hide()
	get_tree().paused = false

func _on_resume() -> void:
	hide_pause()

func _on_restart() -> void:
	hide_pause()
	if LevelManager.instance:
		LevelManager.instance.reload_level()

func _on_exit() -> void:
	hide_pause()
	get_tree().change_scene_to_file("res://scenes/game/level_selector.tscn")
