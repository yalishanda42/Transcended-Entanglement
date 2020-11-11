extends Node2D

signal exit_special_scene

const RING_RES = "res://Assets/Images/ring.png"
const HEART_RES = "res://Assets/Images/weapon-short.png"
var ring = false

var special_song: Resource = load("res://Assets/Sounds/Alcest.ogg")

func enter(ring = false):
	Music.play(special_song)
	$re.frozen = false
	$ItemArea.visible = true
	$Label2.visible = false
	self.ring = ring

	if ring:
		$ItemArea/item.texture = load(RING_RES)
		$Label.text = "IT'S DANGEROUS TO\nLIVE ALONE! TAKE THIS"
	else:
		$ItemArea/item.texture = load(HEART_RES)
		$Label.text = "IT'S DANGEROUS TO GO\nALONE! TAKE THIS"

func _on_ExitArea_body_entered(body):
	$re.frozen = true
	if ring:
		Game.win_game()
	else:
		ScreenFade.state = ScreenFade.OUT
		if ScreenFade.state != ScreenFade.BLACK:
			yield(ScreenFade, "fade_complete")
		ScreenFade.state = ScreenFade.IN
		emit_signal("exit_special_scene")


func _on_ItemArea_body_entered(body):
	if not ring:
		$ItemArea.visible = false
		$Label2.visible = true
		$re.shortWeaponUnlocked = true
	else:
		Game.win_game()


