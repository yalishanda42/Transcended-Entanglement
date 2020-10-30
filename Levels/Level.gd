extends Node2D

var reHasReachedGoal = false
var aiHasReachedGoal = false

const re_start = Vector2(7, 16)
const ai_start = Vector2(9, 16)

const NPC_RESOURCE = "res://Levels/npc.tscn"

var level = 1
const MAX_LEVEL = 2
const LEVEL_SETUP = {
	2: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xoooooooxooooooox",
			"xxxxxxxxxxxxxxxxx",
		],
		"npc": [
			[Vector2(5, 5), Vector2(0, 1)],
			[Vector2(2, 12), Vector2(1, 0)],
		],
	}
}

const __TILEMAP_INDEX = {
	"x": 1,
	"o": 2,
	"g": 0
}

func _ready()->void:
	Hud.timeLeft = 120
	Hud.visible = true
	PauseMenu.can_show = true
	get_tree().paused = false

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false


func _on_GoalArea_body_entered(body):
	if body.get_name() == "rebody":
		reHasReachedGoal = true
	elif body.get_name() == "ajbody":
		aiHasReachedGoal = true

	if reHasReachedGoal and aiHasReachedGoal:
		get_tree().paused = true
		yield(get_tree().create_timer(2.0), "timeout")

		# TODO: show intermediate screen when unlocking item
		level_up()


func _on_GoalArea_body_exited(body):
	if body.get_name() == "rebody":
		reHasReachedGoal = false
	elif body.get_name() == "ajbody":
		aiHasReachedGoal = false

func _on_character_die():
	get_tree().paused = true
	# TODO: handle transition here
	Game.take_life()


func level_up():
	level += 1
	if level > MAX_LEVEL:
		Game.win_game()
		return

	var level_data = LEVEL_SETUP[level]

	# Load tiles
	var tiles = level_data["tiles"]
	for row in range(len(tiles)):
		for col in range(len(tiles[row])):
			var cell_index = __TILEMAP_INDEX[tiles[row][col]]
			$TileMap.set_cell(col, row, cell_index)

	# Delete current npc's
	for node in get_children():
		if "npc" in node.name:
			node.queue_free()

	# Create new npc's
	var npc_scene = load(NPC_RESOURCE)
	var npc_data = level_data["npc"]
	for npc_list in npc_data:
		var npc = npc_scene.instance()
		add_child(npc, true)
		npc.direction = npc_list[1]
		npc.position = __get_tile_center(npc_list[0])

	# Move re and ai to their start points
	$rebody.position = __get_tile_center(re_start)
	$ajbody.position = __get_tile_center(ai_start)

	get_tree().paused = false
	$TileMap.update_dirty_quadrants()


func __get_tile_center(tile_location_vector):
	var result = $TileMap.map_to_world(tile_location_vector)
	result.x += 8
	result.y += 8
	return result
