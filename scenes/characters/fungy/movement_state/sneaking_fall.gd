extends PlayerStateBase
@onready var step: AudioStreamPlayer2D = $"../../Step"

func start():
	player.animation_player.play(player.fungy_constants.ANIMATION_SNEAKING_FALL)

func on_physics_process(delta):
	var direction = Input.get_axis("p1_left", "p1_right")
	player.velocity.x = direction * player.fungy_constants.SNEAKING_SPEED
	
	if direction: player.sprite.flip_h = direction < 0
	
	if player.velocity.y >= 0 and player.is_on_floor():
		step.play()
		state_machine.change_to("SneakingIdle" if direction == 0 else "Sneaking")
	
	_inputs()
	handle_physics(delta)

func _inputs():
	if not Input.is_action_pressed("p1_sneak") and not player.umbral.has_overlapping_bodies():
		state_machine.change_to("Falling")
