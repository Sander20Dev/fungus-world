extends PlayerStateBase

func start():
	player.animation_player.play(player.fungy_constants.ANIMATION_JUMPING)

func on_physics_process(delta):
	var direction = Input.get_axis("p1_left", "p1_right")
	player.velocity.x = direction * player.fungy_constants.SPEED
	
	if direction: player.sprite.flip_h = direction < 0
	
	if player.is_on_floor() and player.velocity.y >= 0:
		player.velocity.y = player.fungy_constants.JUMP_VELOCITY
	
	if player.velocity.y > 0:
		state_machine.change_to("Falling")
	
	_inputs()
	handle_physics(delta)

func _inputs():
	if Input.is_action_pressed("p1_sneak"):
		state_machine.change_to("SneakingJump")
