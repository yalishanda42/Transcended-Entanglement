extends KinematicBody2D

signal die

export(bool) var isInverted = false
export(String, FILE, "*.tscn") var shortWeaponScene = "res://Levels/weaponshort.tscn"

var speed = 60
var loadedShortWeaponScene
var lastDirection
var shortWeaponInstance = null

func _ready():
	lastDirection = Vector2(0, 1)
	loadedShortWeaponScene = load(shortWeaponScene)

func _process(delta):
	if not get_tree().paused and shortWeaponInstance == null:
		# Move only if weapon not spawned
		
		var dir = Vector2.ZERO
		dir.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
		dir.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
		
		if isInverted:
			dir.x = -dir.x
			
		dir = dir.normalized()
			
		if dir.x != 0 or dir.y != 0:
			print(dir)
			lastDirection = Vector2(0, dir.y) if dir.x == 0 else Vector2(dir.x, 0)
		
		move_and_slide(dir * speed)
		
		# Animation
		
		if lastDirection.x > 0:
			$AnimatedSprite.animation = "sideways"
			$AnimatedSprite.flip_h = false
		elif lastDirection.x < 0:
			$AnimatedSprite.animation = "sideways"
			$AnimatedSprite.flip_h = true
		elif lastDirection.y > 0:
			$AnimatedSprite.animation = "down"
			$AnimatedSprite.flip_h = false
		elif lastDirection.y < 0:
			$AnimatedSprite.animation = "up"
			$AnimatedSprite.flip_h = false
			
		if dir.x == 0 and dir.y == 0:
			$AnimatedSprite.frame = 0
		
		# Weapon
		
		if Input.get_action_strength("Primary"):
			spawn_short_weapon()

func _on_Area2D_body_entered(body):
	if "npc" in body.name:
		emit_signal("die")
		
func spawn_short_weapon():
	var weapon = loadedShortWeaponScene.instance()
	add_child(weapon)
	weapon.position = lastDirection * 16
	weapon.connect("body_entered", self, "_on_short_weapon_area_body_entered")
	$"short-weapon-timer".start()
	shortWeaponInstance = weapon

func _on_short_weapon_area_body_entered(body):
	if "npc" in body.name:
		body.queue_free()
		# TODO: pacify

func _on_shortweapontimer_timeout():
	shortWeaponInstance.queue_free()
	shortWeaponInstance = null
