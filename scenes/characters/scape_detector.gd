extends Area2D

var can_escape = false

@onready var player: Fungy = self.owner

func _process(delta: float):
	if not player.can_exit: return
	
	can_escape = has_overlapping_areas()
	
	if can_escape and Input.is_action_just_pressed("p1_sneak"):
		if player.escaped:
			player.show()
		else:
			player.hide()
		player.escaped = not player.escaped


func _reset() -> void:
	can_escape = false
	player.escaped = false
	player.show()
