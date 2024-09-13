class_name PlayerStateBase extends StateBase

var player: Fungy :
	set(val):
		controlled_node = val
	get():
		return controlled_node

func handle_physics(delta:float):
	player.velocity += player.get_gravity() * delta

	player.move_and_slide()

func on_physics_process(delta):
	handle_physics(delta)
