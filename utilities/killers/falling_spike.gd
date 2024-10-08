class_name FallingSpike extends CharacterBody2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D

var active = false

func _physics_process(delta: float) -> void:
	if not active and ray_cast_2d.is_colliding():
		var collide = ray_cast_2d.get_collider()
		if collide is Fungy:
			active = true
	
	if not active: return
	
	velocity += get_gravity() * delta * 2
	move_and_slide()

func _on_detector_body_entered(body: Node2D) -> void:
	if body is Fungy:
		LevelManager.instance.current_level_states.kill()
	queue_free()
