class_name TransitionLevel
extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal animation_end(anim_name: StringName)

func transition_in():
	if not animation_player: animation_player = $AnimationPlayer
	animation_player.play("in")
func transition_out():
	if not animation_player: animation_player = $AnimationPlayer
	animation_player.play("out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_end.emit(anim_name)
