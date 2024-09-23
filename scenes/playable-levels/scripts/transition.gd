class_name TransitionLevel
extends CanvasLayer

var animation_player: AnimationPlayer
var canvas_modulate: CanvasModulate

signal animation_end(anim_name: StringName)

func _setup():
	if not animation_player: animation_player = $AnimationPlayer
	if not canvas_modulate: canvas_modulate = $CanvasModulate
	canvas_modulate.color = Levels.tiles_color[Levels.currentRawWorld]

func transition_in():
	_setup()
	animation_player.play("in")
func transition_out():
	_setup()
	animation_player.play("out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_end.emit(anim_name)
