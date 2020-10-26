extends VBoxContainer

func _ready()->void:
	MenuEvent.connect("Options", self, "on_options")
	
	if OS.get_name() == "HTML5":
		$"HBoxContainer/ButtonContainer/Exit".visible = false
	#Localization
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()

func _on_NewGame_pressed()->void:
	Game.emit_signal("NewGame")


func _on_Options_pressed()->void:
	MenuEvent.Options = true

func _on_Exit_pressed()->void:
	Game.emit_signal("Exit")

#Localization
func retranslate()->void:
	find_node("NewGame").text = tr("NEW_GAME")
	find_node("Options").text = tr("OPTIONS")
	find_node("Exit").text = tr("EXIT")
