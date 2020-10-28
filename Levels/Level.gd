extends Node2D

func _ready()->void:
	Hud.timeLeft = 120
	Hud.visible = true
	PauseMenu.can_show = true

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false
