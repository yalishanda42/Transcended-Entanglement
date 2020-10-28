extends KinematicBody2D


export(int) var speed = 25
export(Vector2) var direction = Vector2(-1, 0)

func _ready():
	$AnimatedSprite.playing = true
	direction = direction.normalized()

func _process(delta):
	if not get_tree().paused:
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
		
		$AnimatedSprite.flip_h = direction.x > 0
