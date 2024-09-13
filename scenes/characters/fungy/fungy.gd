class_name Fungy extends CharacterBody2D

var fungy_constants = FungyConstants.new()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var umbral: Area2D = $Umbral

var can_exit = false
var escaped = false
func allow_exit():
	can_exit = true

func _ready():
	Global.players[0] = self
