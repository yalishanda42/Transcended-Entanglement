extends VBoxContainer

var is_time = false

func _ready():
	$HBoxContainer/ButtonContainer/TryAgain.grab_focus()
	if is_time:
		$HBoxContainer/ButtonContainer/Label.text = "\n\n\n\n"
		$"HBoxContainer/ButtonContainer/time-no-one".visible = true

func _on_TryAgain_pressed():
	Game.emit_signal("NewGame")

func _on_MainMenu_pressed():
	Game.emit_signal("MainMenu")
