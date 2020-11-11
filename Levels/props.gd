extends Area2D

const HEART_RES = "res://Assets/Images/weapon-short.png"
const CLOCK_RES = "res://Assets/Images/clock.png"

var type = "heart"

func _ready():
	if type == "clock":
		var clock_png = load(CLOCK_RES)
		$Sprite.texture = clock_png
	elif type == "heart":
		var heart_png = load(HEART_RES)
		$Sprite.texture = heart_png


func _on_Area2D_body_entered(body):
	if body.name == "ajbody" or body.name == "rebody":
		SfxManager.play("prop")
		if type == "clock":
			Hud.timeLeft += 10
		elif type == "heart":
			Hud.life += 1
		queue_free()
