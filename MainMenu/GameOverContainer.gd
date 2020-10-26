extends VBoxContainer

func _ready():
	$HBoxContainer/ButtonContainer/TryAgain.grab_focus()

func _on_TryAgain_pressed():
	Game.emit_signal("NewGame")

func _on_MainMenu_pressed():
	Game.emit_signal("MainMenu")
