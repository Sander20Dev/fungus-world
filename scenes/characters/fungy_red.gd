class_name FungyRed
extends CharacterBody2D


const SPEED = 150.0
const SNEAKING_SPEED_PORCENTAGE = 0.5
const JUMP_VELOCITY = -450.0

var direction = 0
var can_stand = true
var really_can_exit = false
var escaped = false

@onready var animated: AnimatedSprite2D = $AnimatedSprite2D
@onready var normal_collision: CollisionShape2D = $NormalCollision
@onready var sneaked_collision: CollisionShape2D = $SneakedCollision
@onready var umbral: Area2D = $Umbral

func _ready() -> void:
	Global.players[0] = self

func _physics_process(delta: float) -> void:
	if escaped:
		animated.pause()
		return

	direction = Input.get_axis("red_left", "red_right")
	can_stand = not umbral.has_overlapping_bodies()
	
	var on_floor = is_on_floor()
	var is_sneaking = Input.is_action_pressed("red_sneak") or not can_stand
	var is_jumping = Input.is_action_just_pressed("red_jump")

	if is_sneaking and on_floor:
		normal_collision.disabled = true
		sneaked_collision.disabled = false
	else:
		normal_collision.disabled = false
		sneaked_collision.disabled = true
		

	if on_floor:
		if is_jumping:
			_player_jumping(delta)
		elif is_sneaking:
			_player_sneaking(delta)
		else:
			_player_walking(delta)
	else:
		_player_on_air(delta)

	move_and_slide()

func _flip_by_direction():
	if direction:
		animated.flip_h = direction < 0

func _player_walking(delta: float):
	_flip_by_direction()
	velocity.x = direction * SPEED
	
	if direction:
		animated.play("walking")
	else:
		animated.play("idle")

func _player_jumping(delta: float):
	velocity.y = JUMP_VELOCITY

func _player_on_air(delta: float):
	var fall_force = get_gravity() * delta
	velocity += fall_force

	_flip_by_direction()
	velocity.x = direction * SPEED

	if fall_force.y > 0:
		animated.play("jumping")
	else:
		animated.play("falling")

func _player_sneaking(delta: float):
	_flip_by_direction()
	velocity.x = SNEAKING_SPEED_PORCENTAGE * direction * SPEED
	
	if direction:
		animated.play("sneak_walking")
	else:
		animated.play("sneak_idle")

func can_exit():
	really_can_exit = true
