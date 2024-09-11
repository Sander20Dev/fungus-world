class_name FungyRed
extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -450.0

@onready var animated: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var on_floor = is_on_floor()
	# Add the gravity.
	if not on_floor:
		velocity += get_gravity() * delta
		animated.play("jumping")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("red_left", "red_right")
	if direction:
		velocity.x = direction * SPEED
		animated.flip_h = direction < 0
		if is_on_floor: animated.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if on_floor: animated.play("idle")

	move_and_slide()
