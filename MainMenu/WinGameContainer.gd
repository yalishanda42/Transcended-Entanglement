extends VBoxContainer

var song: Resource = load("res://Assets/Sounds/Dream_Theater_-_Hollow_Years-NES.ogg")

func _ready():
	Music.play(song)
	
func _process(delta):
	if Input.get_action_strength("Primary") > 0:
		Game.emit_signal("MainMenu")
