class_name MobileControls
extends CanvasLayer

func _ready():
	_setup_btn($Move/Left)
	_setup_btn($Move/Right)
	_setup_btn($Actions/Jump)
	_setup_btn($Actions/Sneak)
	_setup_btn($Actions/Interact)

func _setup_btn(btn: TouchScreenButton):
	btn_released(btn).call()
	btn.pressed.connect(btn_pressed(btn))
	btn.released.connect(btn_released(btn))

func btn_pressed(btn: TouchScreenButton):
	return func():
		btn.modulate = Color("#88888896")
func btn_released(btn: TouchScreenButton):
	return func():
		btn.modulate = Color("#FFFFFF46")

func _process(delta: float) -> void:
	if not LevelManager.instance: return
	if LevelManager.instance.can_player_interact: $Actions/Interact.show()
	else: $Actions/Interact.hide()
