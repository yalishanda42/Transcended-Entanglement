extends Node2D

signal exit_special_scene


func _on_ExitArea_body_entered(body):
	emit_signal("exit_special_scene")


func _on_ItemArea_body_entered(body):
	$ItemArea.visible = false
	$Label2.visible = true
	$rebody.shortWeaponUnlocked = true
