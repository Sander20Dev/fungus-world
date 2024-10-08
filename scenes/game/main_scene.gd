extends CanvasLayer
@onready var is_mobile: CheckButton = $IsMobile
@onready var canvas_modulate: CanvasModulate = $CanvasModulate

@onready var play_button: Button = $PlayButton
@onready var settings_button: Button = $SettingsButton
@onready var quit_button: Button = $QuitButton

func _ready() -> void:
	Global.reset_color()
	canvas_modulate.color = Global.default_tint
	
	play_button.pressed.connect(_start_game)
	settings_button.pressed.connect(_open_settings)
	quit_button.pressed.connect(_quit_game)

func _start_game():
	Global.is_mobil = is_mobile.button_pressed
	get_tree().change_scene_to_file("res://scenes/game/world_selector.tscn")

func _open_settings():
	get_tree().change_scene_to_file("res://scenes/game/settings_layer.tscn")

func _quit_game():
	get_tree().quit()
