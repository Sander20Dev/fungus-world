extends CanvasLayer

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/playable-levels/level1/level_1_1.tscn")
