extends Node2D

signal exit_special_scene

func enter():
	$re.frozen = false
	$ItemArea.visible = true
	$Label2.visible = false

func _on_ExitArea_body_entered(body):
	ScreenFade.state = ScreenFade.OUT
	if ScreenFade.state != ScreenFade.BLACK:
		yield(ScreenFade, "fade_complete")
	ScreenFade.state = ScreenFade.IN
	emit_signal("exit_special_scene")
	$re.frozen = true

func _on_ItemArea_body_entered(body):
	$ItemArea.visible = false
	$Label2.visible = true
	$re.shortWeaponUnlocked = true

	
