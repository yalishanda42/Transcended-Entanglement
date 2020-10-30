extends Node2D

var re_has_reached_goal = false
var ai_has_reached_goal = false

const RE_START = Vector2(7, 16)
const AI_START = Vector2(9, 16)

const NPC_RESOURCE = "res://Levels/npc.tscn"

var level = 1
const MAX_LEVEL = 2
const LEVEL_SETUP = {
	1: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xoxxxxxxxxxxoxxox",
			"xoooooooxooooooox",
			"xoxxxxxoxoxxxoxxx",
			"xoooooooxooooooox",
			"xoxxoxxoxxoxxxxox",
			"xooxooooxooooxoox",
			"xxoxxoxxxoxxoxxox",
			"xoooooooxoooooxox",
			"xxoxoxxoxoxxxoxox",
			"xooxooooxoxooooox",
			"xoxxoxxxxoxoxxxox",
			"xoooooooxooooooox",
			"xxxoxxxxxxxxxxxox",
			"xoooooooxooooooox",
			"xxxxxxxxxxxxxxxxx",
		],
		"npc": [
			[Vector2(7, 4), Vector2(-1, 0)],
			[Vector2(10, 7), Vector2(0, 1)],
		],
		"time": 120
	},
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
		"time": 120
	}
}

const __TILEMAP_INDEX = {
	"x": 1,
	"o": 2,
	"g": 0
}

func _ready()->void:
	Hud.visible = true
	PauseMenu.can_show = true
	load_level()

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false


func _on_GoalArea_body_entered(body):
	if body.name == "rebody":
		re_has_reached_goal = true
	elif body.name == "ajbody":
		ai_has_reached_goal = true

	if re_has_reached_goal and ai_has_reached_goal:
		get_tree().paused = true
		yield(get_tree().create_timer(2.0), "timeout")

		# TODO: show intermediate screen when unlocking item
		level_up()


func _on_GoalArea_body_exited(body):
	if body.name == "rebody":
		re_has_reached_goal = false
	elif body.name == "ajbody":
		ai_has_reached_goal = false

func _on_character_die():
	get_tree().paused = true
	yield(get_tree().create_timer(2.0), "timeout")
	ScreenFade.state = ScreenFade.OUT
	if ScreenFade.state != ScreenFade.BLACK:
		yield(ScreenFade, "fade_complete")
	ScreenFade.state = ScreenFade.IN

	var curr = Hud.life
	var new = curr - 1
	Hud.life = new
	if new <= 0:
		Game.game_over()
		return

	load_level()

func level_up():
	level += 1
	if level > MAX_LEVEL:
		Game.win_game()
		return

	load_level()


func load_level():
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
	for i in range(len(npc_data)):
		var npc_list = npc_data[i]
		var npc = npc_scene.instance()
		add_child(npc, true)
		npc.name = "npc" + str(i)
		npc.direction = npc_list[1]
		npc.position = __get_tile_center(npc_list[0])

	# Move re and ai to their start points
	$rebody.position = __get_tile_center(RE_START)
	$ajbody.position = __get_tile_center(AI_START)
	re_has_reached_goal = false
	ai_has_reached_goal = false

	Hud.timeLeft = level_data["time"]
	get_tree().paused = false
	$TileMap.update_dirty_quadrants()


func __get_tile_center(tile_location_vector):
	var result = $TileMap.map_to_world(tile_location_vector)
	result.x += 8
	result.y += 8
	return result
