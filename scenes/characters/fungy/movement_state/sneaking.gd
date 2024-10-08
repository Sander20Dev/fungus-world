extends PlayerStateBase

func start():
	player.animation_player.play(player.fungy_constants.ANIMATION_SNEAKING)

func on_physics_process(delta):
	var direction = Input.get_axis("p1_left", "p1_right")
	player.velocity.x = direction * player.fungy_constants.SNEAKING_SPEED
	
	if direction: player.sprite.flip_h = direction < 0
	
	if player.velocity.y > 0:
		state_machine.change_to("SneakingFall")
	
	_inputs()
	handle_physics(delta)

func _inputs():
	if not Input.is_action_pressed("p1_sneak") and not player.umbral.has_overlapping_bodies():
		state_machine.change_to("Walking")
	if not Input.is_action_pressed("p1_left") and not Input.is_action_pressed("p1_right"):
		state_machine.change_to("SneakingIdle")
	if player.is_on_floor() and Input.is_action_pressed("p1_jump"):
		state_machine.change_to("SneakingJump")
