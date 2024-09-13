extends PlayerStateBase

func start():
	player.animation_player.play(player.fungy_constants.ANIMATION_IDLE)

func on_physics_process(delta):
	var direction = Input.get_axis("red_left", "red_right")
	player.velocity.x = direction
	if direction: state_machine.change_to("Walking")
	handle_physics(delta)

func on_input(_event):
	if Input.is_action_just_pressed("red_sneak"):
		state_machine.change_to("SneakingIdle")
	if player.is_on_floor() and Input.is_action_just_pressed("red_jump"):
		state_machine.change_to("Jumping")
