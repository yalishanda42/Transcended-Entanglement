extends KinematicBody2D


export(int) var speed = 25
export(Vector2) var direction = Vector2(-1, 0)
export(int) var spawn_prop_chance = 20
var PROP_RESOURCE = "res://Levels/props.tscn"

const COLORS = ["red", "orange", "pink", "blue"]
var color = "red"

var is_stopped = false

func kill():
	SfxManager.play("kill")
	var spawn_prop = (randi() % 100 + 1) <= spawn_prop_chance
	if spawn_prop:
		var prop_scene = load(PROP_RESOURCE)
		var prop = prop_scene.instance()
		prop.name = "prop" + name
		prop.type = "clock"
		get_parent().add_child(prop)
		prop.position = position
	queue_free()

func _ready():
	color = COLORS[randi() % len(COLORS)]
	$AnimatedSprite.animation = "down-" + color
	$AnimatedSprite.playing = true
	direction = direction.normalized()

func _process(delta):
	if not Game.suspended and not is_stopped:
		var velocity = move_and_slide(direction * speed)
		if velocity.x == 0 and velocity.y == 0:  #collided
			# new direction has to be picked
			var rand = randf()  # 0...1

			if direction.x == 0:
				direction.x = -1 if rand < 0.5 else 1
				direction.y = 0
			elif direction.y == 0:
				direction.y = -1 if rand < 0.5 else 1
				direction.x = 0

		if direction.x > 0:
			$AnimatedSprite.animation = "side-" + color
			$AnimatedSprite.flip_h = false
		elif direction.x < 0:
			$AnimatedSprite.animation = "side-" + color
			$AnimatedSprite.flip_h = true
		elif direction.y > 0:
			$AnimatedSprite.animation = "down-" + color
		elif direction.y < 0:
			$AnimatedSprite.animation = "up-" + color
