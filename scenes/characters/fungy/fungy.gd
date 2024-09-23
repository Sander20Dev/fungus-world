class_name Fungy extends CharacterBody2D

var fungy_constants = FungyConstants.new()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var umbral: Area2D = $Umbral

signal reset_player()

var can_exit = false
var escaped = false
func allow_exit():
	can_exit = true

func _ready():
	Global.players[0] = self

func reset():
	reset_player.emit()

func do_untangible():
	set_physics_process(false)
	self.set_collision_layer_value(1, false)
	pass
func do_tangible():
	set_physics_process(true)
	self.set_collision_layer_value(1, true)
	pass
