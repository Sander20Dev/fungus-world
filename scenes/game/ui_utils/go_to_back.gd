extends TextureButton

signal on_go_to_back()

@export var back_scene: PackedScene

func _on_pressed() -> void:
	on_go_to_back.emit()
	if back_scene:
		get_tree().change_scene_to_packed(back_scene)
