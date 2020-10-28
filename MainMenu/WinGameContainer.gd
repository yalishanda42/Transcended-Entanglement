extends VBoxContainer

func _ready():
	$HBoxContainer/ButtonContainer/MainMenu.grab_focus()


func _on_MainMenu_pressed():
	Game.emit_signal("MainMenu")
