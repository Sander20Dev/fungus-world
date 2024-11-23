@tool

class_name ActiveLazer
extends Lazer

func use_button():
	_lazer_off()

func button_disable():
	_lazer_on()

func _lazer_off():
	disabled = true
func _lazer_on():
	disabled = false
