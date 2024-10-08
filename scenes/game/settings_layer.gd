class_name SettingsLayer extends CanvasLayer

@onready var canvas_modulate: CanvasModulate = $CanvasModulate

@onready var fullscreen: CheckBox = $HVideo/CheckBoxs/Fullscreen
@onready var borderless: CheckBox = $HVideo/CheckBoxs/Borderless
@onready var v_sync: CheckBox = $HVideo/CheckBoxs/VSync

@onready var language_selector: OptionButton = $LanguageSelector

func _ready() -> void:
	Global.reset_color()
	canvas_modulate.color = Global.default_tint
	
	fullscreen.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	borderless.button_pressed = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	v_sync.button_pressed = DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED
	
	print(TranslationServer.get_locale().substr(0, 2))
	language_selector.selected = languages.find(TranslationServer.get_locale().substr(0, 2))

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if toggled_on else DisplayServer.WINDOW_MODE_WINDOWED)


func _on_borderless_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)


func _on_v_sync_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if toggled_on else DisplayServer.VSYNC_DISABLED)


var languages = [
	"en",
	"es"
]
func _on_language_selector_item_selected(index: int) -> void:
	TranslationServer.set_locale(languages[index])
