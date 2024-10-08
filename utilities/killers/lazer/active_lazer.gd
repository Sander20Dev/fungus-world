@tool

class_name ActiveLazer
extends Lazer

func use_button():
	_lazer_off()

func _lazer_off():
	disabled = true
