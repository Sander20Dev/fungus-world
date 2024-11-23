class_name FadingBlock
extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var disabled = false :
	set(val):
		disabled = val
		if val:
			animation_player.play("fade_out")
		else:
			animation_player.play("fade_in")


func _on_detector_body_entered(body: Node2D) -> void:
	if body is Fungy:
		disabled = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		timer.start()

func _on_timer_timeout() -> void:
	disabled = false
