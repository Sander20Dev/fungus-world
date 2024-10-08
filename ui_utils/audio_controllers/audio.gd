extends HSlider

@export var bus_idx = 0

func _ready():
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_idx))
	
	value_changed.connect(_on_change)

func _on_change(volume: float):
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(volume))
