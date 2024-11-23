class_name Key
extends Area2D

@export var door: Door
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var key_catch: AudioStreamPlayer2D = $KeyCatch
@onready var timer_kill: Timer = $TimerKill

var used = false

func _ready() -> void:
	animation_player.play("idle")


func _on_body_entered(body: Node2D) -> void:
	if used: return
	
	LevelManager.instance.fungy.collect_item(Global.ITEMS_NAME.KEY)
	#if not door or used: return
	used = true
	key_catch.play()
	#door.open_the_door()
	timer_kill.start()
	hide()
	pass


func _on_timer_timeout() -> void:
	queue_free()
	pass
