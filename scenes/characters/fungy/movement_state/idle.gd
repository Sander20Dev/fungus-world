extends PlayerStateBase

func start():
	player.animation_player.play(player.fungy_constants.ANIMATION_IDLE)

func on_physics_process(delta):
	var direction = Input.get_axis("p1_left", "p1_right")
	player.velocity.x = direction
	if direction: state_machine.change_to("Walking")
	if player.velocity.y > 0:
		state_machine.change_to("Falling")
	handle_physics(delta)

func on_input(_event):
	if Input.is_action_pressed("p1_sneak"):
		state_machine.change_to("SneakingIdle")
	if player.is_on_floor() and Input.is_action_pressed("p1_jump"):
		state_machine.change_to("Jumping")
