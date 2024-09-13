extends PlayerStateBase

func start():
	player.animation_player.play(player.fungy_constants.ANIMATION_JUMPING)

func on_physics_process(delta):
	var direction = Input.get_axis("red_left", "red_right")
	player.velocity.x = direction * player.fungy_constants.SPEED
	
	if direction: player.sprite.flip_h = direction < 0
	
	if player.is_on_floor() and player.velocity.y >= 0:
		player.velocity.y = player.fungy_constants.JUMP_VELOCITY
	
	if player.velocity.y > 0:
		state_machine.change_to("Falling")
	
	handle_physics(delta)
