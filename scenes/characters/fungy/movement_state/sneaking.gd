extends PlayerStateBase

func start():
	player.animation_player.play(player.fungy_constants.ANIMATION_SNEAKING)

func on_physics_process(delta):
	var direction = Input.get_axis("red_left", "red_right")
	player.velocity.x = direction * player.fungy_constants.SNEAKING_SPEED
	
	if direction: player.sprite.flip_h = direction < 0
	
	_inputs()
	handle_physics(delta)

func _inputs():
	if not Input.is_action_pressed("red_sneak") and not player.umbral.has_overlapping_bodies():
		state_machine.change_to("Walking")
	if not Input.is_action_pressed("red_left") and not Input.is_action_pressed("red_right"):
		state_machine.change_to("SneakingIdle")
