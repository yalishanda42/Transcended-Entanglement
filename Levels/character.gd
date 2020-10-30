extends KinematicBody2D

signal die

export(bool) var isInverted = false

var speed = 60

func _process(delta):
	if not get_tree().paused:
		var dir = Vector2.ZERO
		dir.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
		dir.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
		
		if isInverted:
			dir.x = -dir.x
		
		move_and_slide(dir * speed)

func _on_Area2D_body_entered(body):
	if "npc" in body.name:
		emit_signal("die")
