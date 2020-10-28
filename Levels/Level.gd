extends Node2D

var reHasReachedGoal = false
var aiHasReachedGoal = false

func _ready()->void:
	Hud.timeLeft = 120
	Hud.visible = true
	PauseMenu.can_show = true

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false


func _on_GoalArea_body_entered(body):
	if body.get_name() == "rebody":
		reHasReachedGoal = true
	elif body.get_name() == "ajbody":
		aiHasReachedGoal = true
	
	if reHasReachedGoal and aiHasReachedGoal:
		Game.advance_level()


func _on_GoalArea_body_exited(body):
	if body.get_name() == "rebody":
		reHasReachedGoal = false
	elif body.get_name() == "ajbody":
		aiHasReachedGoal = false
