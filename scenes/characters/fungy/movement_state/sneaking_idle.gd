extends PlayerStateBase

func start():
	player.animation_player.play(player.fungy_constants.ANIMATION_SNEAKING_IDLE)

func on_physics_process(delta):
	player.velocity.x = 0
	_inputs()
	handle_physics(delta)

func _inputs():
	if not Input.is_action_pressed("red_sneak") and not player.umbral.has_overlapping_bodies():
		state_machine.change_to("Idle")
	if Input.is_action_just_pressed("red_left") or Input.is_action_just_pressed("red_right"):
		state_machine.change_to("Sneaking")
