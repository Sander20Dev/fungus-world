extends PlayerStateBase

func start():
	player.animation_player.play(player.fungy_constants.ANIMATION_SNEAKING_IDLE)

func on_physics_process(delta):
	player.velocity.x = 0
	
	if player.velocity.y > 0:
		state_machine.change_to("SneakingFall")
	
	_inputs()
	handle_physics(delta)

func _inputs():
	if not Input.is_action_pressed("p1_sneak") and not player.umbral.has_overlapping_bodies():
		state_machine.change_to("Idle")
	if Input.is_action_just_pressed("p1_left") or Input.is_action_just_pressed("p1_right"):
		state_machine.change_to("Sneaking")
	if player.is_on_floor() and Input.is_action_pressed("p1_jump"):
		state_machine.change_to("SneakingJump")
