extends PlayerStateBase

func start():
	player.animation_player.play("walking")

func on_physics_process(delta: float):
	var direction = Input.get_axis("red_left", "red_right")
	player.velocity.x = direction * player.fungy_constants.SPEED
	
	if direction: player.sprite.flip_h = direction < 0
	else: state_machine.change_to("Idle")
	
	handle_physics(delta)

func on_input(event):
	if not Input.is_action_pressed("red_left") and not Input.is_action_pressed("red_right"):
		state_machine.change_to("Idle")
	if Input.is_action_just_pressed("red_sneak"):
		state_machine.change_to("Sneaking")
	if player.is_on_floor() and Input.is_action_just_pressed("red_jump"):
		state_machine.change_to("Jumping")
