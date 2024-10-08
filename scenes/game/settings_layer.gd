class_name SettingsLayer extends CanvasLayer

@onready var canvas_modulate: CanvasModulate = $CanvasModulate

@onready var fullscreen: CheckBox = $HVideo/CheckBoxs/Fullscreen
@onready var borderless: CheckBox = $HVideo/CheckBoxs/Borderless
@onready var v_sync: CheckBox = $HVideo/CheckBoxs/VSync

@onready var master_slider: HSlider = $HAudio/Sliders/MasterSlider
@onready var music_slider: HSlider = $HAudio/Sliders/MusicSlider
@onready var sfx_slider: HSlider = $HAudio/Sliders/SfxSlider

func _ready() -> void:
	Global.reset_color()
	canvas_modulate.color = Global.default_tint
	
	fullscreen.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	borderless.button_pressed = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	v_sync.button_pressed = DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED
	
	master_slider.value = AudioServer.get_bus_volume_db(0)
	music_slider.value = AudioServer.get_bus_volume_db(1)
	sfx_slider.value = AudioServer.get_bus_volume_db(2)

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if toggled_on else DisplayServer.WINDOW_MODE_WINDOWED)


func _on_borderless_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)


func _on_v_sync_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if toggled_on else DisplayServer.VSYNC_DISABLED)

func _change_volume(bus_index: int, vol: float):
	AudioServer.set_bus_volume_db(bus_index, vol)


func _on_master_slider_value_changed(value: float) -> void:
	_change_volume(0, value)


func _on_music_slider_value_changed(value: float) -> void:
	_change_volume(1, value)


func _on_sfx_slider_value_changed(value: float) -> void:
	_change_volume(2, value)
