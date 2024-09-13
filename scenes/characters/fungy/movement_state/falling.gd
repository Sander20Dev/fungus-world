extends PlayerStateBase

func on_physics_process(delta):
	var direction = Input.get_axis("red_left", "red_right")
	player.velocity.x = direction * player.fungy_constants.SPEED
	
	if direction: player.sprite.flip_h = direction < 0
	
	if player.velocity.y >= 0 and player.is_on_floor(): 
		state_machine.change_to("Idle" if direction == 0 else "Walking")
	
	handle_physics(delta)
