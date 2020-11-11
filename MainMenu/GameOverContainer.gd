extends VBoxContainer

var is_time = false

var normal_song: Resource = load("res://Assets/Sounds/TheSpiritCarriesOn.ogg")
var time_song: Resource = load("res://Assets/Sounds/WillOTheWisp.ogg")

func _ready():
	if is_time:
		Music.play(time_song)
	else:
		Music.play(normal_song)
	$HBoxContainer/ButtonContainer/TryAgain.grab_focus()
	if is_time:
		$HBoxContainer/ButtonContainer/Label.text = "\n\n\n\n"
		$"HBoxContainer/ButtonContainer/time-no-one".visible = true


func _on_TryAgain_pressed():
	Game.emit_signal("NewGame")

func _on_MainMenu_pressed():
	Game.emit_signal("MainMenu")
