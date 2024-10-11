extends CanvasLayer
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
	
	$MobileMode.text = tr("UI.MAIN_MENU.DISABLE_MOBILE_MODE") if Global.is_mobil else tr("UI.MAIN_MENU.ACTIVE_MOBILE_MODE")
	$MobileMode.pressed.connect(_toogle_mobile_mode)

func _start_game():
	get_tree().change_scene_to_file("res://scenes/game/world_selector.tscn")

func _open_settings():
	get_tree().change_scene_to_file("res://scenes/game/settings_layer.tscn")

func _quit_game():
	get_tree().quit()

func _toogle_mobile_mode():
	Global.is_mobil = not Global.is_mobil
	$MobileMode.text = tr("UI.MAIN_MENU.DISABLE_MOBILE_MODE") if Global.is_mobil else tr("UI.MAIN_MENU.ACTIVE_MOBILE_MODE")
