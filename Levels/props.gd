extends Area2D

func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.name == "ajbody" or body.name == "rebody":
		Hud.life += 1
		queue_free()
