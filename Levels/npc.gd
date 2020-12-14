extends KinematicBody2D


export(int) var speed = 25
export(Vector2) var direction = Vector2(-1, 0)
export(int) var spawn_prop_chance = 20

const PROP_RESOURCE = "res://Levels/props.tscn"
const Level = preload("res://Levels/Level.gd")

const COLORS = ["red", "blue"]
var color = "red"

var is_stopped = false

var is_smart = false
var level_instance: Level

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
	is_smart = randf() <= 0.5
	color = "red" if is_smart else "blue"
	$AnimatedSprite.animation = "down-" + color
	$AnimatedSprite.playing = true
	direction = direction.normalized()

func _process(delta):
	if not Game.suspended and not is_stopped:
		if is_smart:
			# Assuming position is center and radius of circle collision shape is 7
			var left_edge = position + Vector2(-7, 0)
			var right_edge = position + Vector2(7, 0)
			var up_edge = position + Vector2(0, -7)
			var down_edge = position + Vector2(0, 7)
			var left_edge_tile = level_instance.map_to_tile(left_edge)
			var right_edge_tile = level_instance.map_to_tile(right_edge)
			var up_edge_tile = level_instance.map_to_tile(up_edge)
			var down_edge_tile = level_instance.map_to_tile(down_edge)
			if left_edge_tile == right_edge_tile and up_edge_tile == down_edge_tile:
				var tile = level_instance.map_to_tile(position)
				var id = level_instance.position_to_astar_point_id(tile)
				var goal1 = level_instance.get_character_position_in_tilemap("ai")
				var goal2 = level_instance.get_character_position_in_tilemap("re")
				var goal1id = level_instance.position_to_astar_point_id(goal1)
				var goal2id = level_instance.position_to_astar_point_id(goal2)
				var path1 = level_instance.astar.get_point_path(id, goal1id)
				var path2 = level_instance.astar.get_point_path(id, goal2id)
				var shorter_path = path1 if len(path1) <= len(path2) and len(path1) >= 2 else path2
				direction = Vector2.ZERO
				if len(shorter_path) >= 2: # first item is always current node
					var next_node = shorter_path[1]
					var diff = Vector2(next_node.x - tile.x, next_node.y - tile.y)
					direction = diff.normalized()

		var velocity = move_and_slide(direction * speed)

		if not is_smart:
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
