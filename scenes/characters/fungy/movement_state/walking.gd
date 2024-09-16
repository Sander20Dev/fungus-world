extends PlayerStateBase

func start():
	player.animation_player.play("walking")

func on_physics_process(delta: float):
	var direction = Input.get_axis("p1_left", "p1_right")
	player.velocity.x = direction * player.fungy_constants.SPEED
	
	if direction: player.sprite.flip_h = direction < 0
	else: state_machine.change_to("Idle")
	
	if player.velocity.y > 0:
		state_machine.change_to("Falling")
	
	handle_physics(delta)

func on_input(event):
	if not Input.is_action_pressed("p1_left") and not Input.is_action_pressed("p1_right"):
		state_machine.change_to("Idle")
	if Input.is_action_pressed("p1_sneak"):
		state_machine.change_to("Sneaking")
	if player.is_on_floor() and Input.is_action_pressed("p1_jump"):
		state_machine.change_to("Jumping")
