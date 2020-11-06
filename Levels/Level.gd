extends Node2D

var re_has_reached_goal = false
var ai_has_reached_goal = false

const RE_START = Vector2(7, 16)
const AI_START = Vector2(9, 16)

const NPC_RESOURCE = "res://Levels/npc.tscn"
const PROP_RESOURCE = "res://Levels/props.tscn"

const MAX_LEVEL = 16
const WEAPON_MIN_LEVEL = 2
const LEVEL_SETUP = {
	1: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xoxxxxxxxxxxxxxox",
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
			{
				"position": [1, 10],
				"direction": [1, 0]
			},
			{
				"position": [10, 7],
				"direction": [0, 1]
			},
		],
		"prop": [
		],
		"time": 30
	},
	2: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xoxxoxxoxoxxxxxox",
			"xoooooooxoxooooox",
			"xoxoxoxoxoxxxoxox",
			"xoxoxoxoxoooxoxox",
			"xoxoxoxoxoxxxoxox",
			"xoooxoxoxoxooooox",
			"xoxoxoxoxoxoxxxxx",
			"xoxoooooxoxooooox",
			"xoxxxxoxxoxoxxxox",
			"xooooxooxoxoooxox",
			"xoxxoxxoxoxxxoxox",
			"xoooooxoxoooxooox",
			"xxxoxxxoxxxoxxxox",
			"xoooooooxooooooox",
			"xxxxxxxxxxxxxxxxx",
		],
		"npc": [
			{
				"position": [6, 11],
				"direction": [0, 1]
			},
			{
				"position": [9, 7],
				"direction": [0, 1]
			},
			{
				"position": [13, 10],
				"direction": [1, 0]
			},
			{
				"position": [2, 12],
				"direction": [1, 0]
			},
			{
				"position": [7, 4],
				"direction": [0, 1]
			},
			{
				"position": [11, 5],
				"direction": [-1, 0]
			},
		],
		"prop": [
		],
		"time": 30
	},
	3: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xxxxoxxxxxxxoxxxx",
			"xoooooooxooooooox",
			"xoxxxxxoxoxxxxxox",
			"xoxoooooxoxooooox",
			"xoxoxxxoxoxoxxxox",
			"xoooooxoxoooooxox",
			"xoxoxoxoxoxoxoxox",
			"xoxoxoooxoxoxooox",
			"xoooxoxoxoooxoxox",
			"xxxxxoxxxxxxxoxxx",
			"xoooooooxooooooox",
			"xoxoxxxoxoxoxxxox",
			"xoxoxoxoxoxoxoxox",
			"xoooooooxooooooox",
			"xxxxxxxxxxxxxxxxx",
		],
		"npc": [
			{
				"position": [1, 4],
				"direction": [0, 1]
			},
			{
				"position": [7, 4],
				"direction": [0, 1]
			},
			{
				"position": [9, 4],
				"direction": [0, 1]
			},
			{
				"position": [15, 4],
				"direction": [0, 1]
			},
			{
				"position": [1, 13],
				"direction": [1, 0]
			},
			{
				"position": [15, 13],
				"direction": [-1, 0]
			},
		],
		"prop": [
		],
		"time": 30
	},
	4: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xxxoxxxoxxxxoxxxx",
			"xoooooooxooooooox",
			"xoxxxoxxxoxxxoxox",
			"xoooooooxooooooox",
			"xxxxoxxxxxxoxxxxx",
			"xoooooooxooooooox",
			"xxxxoxxxxxxoxxxxx",
			"xoooooooxooooooox",
			"xxxoxxoxxxoxxoxxx",
			"xoooooooxooooooox",
			"xxoxoxoxxoxoxoxox",
			"xoooooooxooooooox",
			"xoxoxoxoxxoxoxoxx",
			"xoooooooxooooooox",
			"xxxxxxxxxxxxxxxxx",
		],
		"npc": [
			{
				"position": [7, 4],
				"direction": [-1, 0]
			},
			{
				"position": [13, 6],
				"direction": [0, -1]
			},
			{
				"position": [1, 8],
				"direction": [1, 0]
			},
			{
				"position": [7, 8],
				"direction": [-1, 0]
			},
			{
				"position": [9, 8],
				"direction": [1, 0]
			},
			{
				"position": [15, 8],
				"direction": [-1, 0]
			},
			{
				"position": [6, 10],
				"direction": [0, 1]
			},
			{
				"position": [10, 10],
				"direction": [0, 1]
			},
		],
		"prop": [
			[1, 8],
			[15, 8],
		],
		"time": 30
	},
	5: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xxxxxxxoxoxxxxxxx",
			"xoooooxoxoxooooox",
			"xoxxxoxoxoxoxxxox",
			"xoxoooxoxoxoooxox",
			"xoxoxxxoxoxxxoxox",
			"xoxoooxoxoxoooxox",
			"xoxxxoxoxoxoxxxox",
			"xoxoooxoxoxoooxox",
			"xoxoxxxoxoxxxoxox",
			"xoxoooxoxoxoooxox",
			"xoxxxoxoxoxxxoxox",
			"xoxoooooxoooooxox",
			"xoxxxxxxxxxxxxxox",
			"xoooooooxooooooox",
			"xxxxxxxxxxxxxxxxx",
		],
		"npc": [
			{
				"position": [1, 4],
				"direction": [0, 1]
			},
			{
				"position": [15, 4],
				"direction": [0, 1]
			},
			{
				"position": [3, 6],
				"direction": [0, 1]
			},
			{
				"position": [3, 12],
				"direction": [0, -1]
			},
			{
				"position": [13, 6],
				"direction": [0, 1]
			},
			{
				"position": [13, 12],
				"direction": [0, -1]
			},
			{
				"position": [7, 3],
				"direction": [0, 1]
			},
			{
				"position": [9, 3],
				"direction": [0, 1]
			},
		],
		"prop": [
		],
		"time": 30
	},
	6: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xoxoxxxxxxxxxxxox",
			"xoxxxoxoxoooooxox",
			"xoooooooxoxxxxxox",
			"xoxxxxxoxooooooox",
			"xoxoooxoxoxxxxxxx",
			"xxxoxoxoxoooxooox",
			"xoooxoxoxxxoxoxox",
			"xxxoxoooxoxoxoxox",
			"xoxoxoxxxoooxoxox",
			"xoxoxoxoxoxxxoxox",
			"xoxoxxxoxoooxoxox",
			"xoxoooooxxxoooxox",
			"xoxxxxxoxoxxxxxox",
		],
		"npc": [
			{
				"position": [1, 11],
				"direction": [0, 1]
			},
			{
				"position": [13, 14],
				"direction": [0, -1]
			},
			{
				"position": [1, 9],
				"direction": [1, 0]
			},
			{
				"position": [5, 12],
				"direction": [0, -1]
			},
			{
				"position": [9, 10],
				"direction": [0, 1]
			},
			{
				"position": [13, 14],
				"direction": [-1, 0]
			},
			{
				"position": [5, 4],
				"direction": [0, 1]
			},
		],
		"prop": [
		],
		"time": 30
	},
	7: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xoooooxogoxooooox",
			"xoxxxoxoxoxoxxxox",
			"xoxoooxoxoxoxoxox",
			"xoxoxxxoxoooxoxox",
			"xoxoooooxxxxxoxox",
			"xoxoxxoxxooooooox",
			"xooooxxxxoxxxxxxx",
			"xoxxxxoxxoooooxox",
			"xoooooooxxxoxoxox",
			"xxxxxoxoxoxoxoxox",
			"xoooxoooxoxooooox",
			"xoxoxxxoxoxxxxxox",
			"xoxoooxoxooxoxoox",
			"xoxxxxxoxoxxoxoxx",
		],
		"npc": [
			{
				"position": [5, 14],
				"direction": [-1, 0]
			},
			{
				"position": [12, 14],
				"direction": [0, 1]
			},
			{
				"position": [15, 9],
				"direction": [0, 1]
			},
			{
				"position": [6, 9],
				"direction": [0, 1]
			},
			{
				"position": [11, 12],
				"direction": [0, -1]
			},
			{
				"position": [13, 4],
				"direction": [0, 1]
			},
			{
				"position": [4, 8],
				"direction": [-1, 0]
			},
		],
		"prop": [
		],
		"time": 30
	},
	8: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xoooooxogoxooooox",
			"xoxxoxxoxoxoxxxox",
			"xooxoxooxoxooxoox",
			"xoxxoxoxxoxxoxxox",
			"xoxooxoxoooxooxox",
			"xoxxoxoxxxoxoxxox",
			"xooxoxoooxoxoxoox",
			"xoxxoxoxxxoxoxxox",
			"xoxooxoxoooxooxox",
			"xoxxoxoxxxoxoxxox",
			"xooxoxoooxoxoxoox",
			"xoxxoxoxxxoxoxxox",
			"xoxooooxooooooxox",
			"xoxxxxxxxxxxxxxox",
		],
		"npc": [
			{
				"position": [5, 2],
				"direction": [-1, 0]
			},
			{
				"position": [2, 4],
				"direction": [-1, 0]
			},
			{
				"position": [2, 8],
				"direction": [-1, 0]
			},
			{
				"position": [2, 12],
				"direction": [-1, 0]
			},
			{
				"position": [8, 12],
				"direction": [-1, 0]
			},
			{
				"position": [8, 8],
				"direction": [-1, 0]
			},
			{
				"position": [13, 10],
				"direction": [-1, 0]
			},
			{
				"position": [13, 6],
				"direction": [-1, 0]
			},
			{
				"position": [3, 6],
				"direction": [1, 0]
			},
			{
				"position": [3, 10],
				"direction": [1, 0]
			},
			{
				"position": [3, 14],
				"direction": [1, 0]
			},
			{
				"position": [8, 14],
				"direction": [1, 0]
			},
			{
				"position": [8, 10],
				"direction": [1, 0]
			},
			{
				"position": [8, 6],
				"direction": [1, 0]
			},
			{
				"position": [14, 4],
				"direction": [1, 0]
			},
			{
				"position": [14, 8],
				"direction": [1, 0]
			},
			{
				"position": [14, 12],
				"direction": [1, 0]
			},
		],
		"prop": [
		],
		"time": 30
	},
	9: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xxxxoxxxxxxxoxxxx",
			"xoooooooxoooooxox",
			"xoxxxxxoxoxxxxxox",
			"xoxoooooxoxooooox",
			"xxxoxxxxxoxxoxxox",
			"xoooxoxoxooxoxoox",
			"xoxxxoxoxxoxoxoxx",
			"xoooooxoxooooxoox",
			"xoxxxxxoxxxxxxoxx",
			"xoooooxoxooooooox",
			"xxxxoxxoxoxxxxxxx",
			"xooxooxoxooooooox",
			"xoxxoxxoxxxxxxxox",
		],
		"npc": [
			{
				"position": [7, 8],
				"direction": [0, 1]
			},
			{
				"position": [5, 8],
				"direction": [0, 1]
			},
			{
				"position": [2, 14],
				"direction": [-1, 0]
			},
			{
				"position": [5, 14],
				"direction": [-1, 0]
			},
			{
				"position": [15, 12],
				"direction": [-1, 0]
			},
			{
				"position": [9, 14],
				"direction": [1, 0]
			},
			{
				"position": [1, 6],
				"direction": [0, -1]
			},
			{
				"position": [13, 4],
				"direction": [-1, 0]
			},
			{
				"position": [15, 4],
				"direction": [0, 1]
			},
			{
				"position": [9, 10],
				"direction": [1, 0]
			},
			{
				"position": [15, 10],
				"direction": [-1, 0]
			},
		],
		"prop": [
			[5, 8],
		],
		"time": 30
	},
	10: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xoxxxxxxxxoxxxxxx",
			"xoooooxoxooooooox",
			"xxxoxoxoxxxxoxxxx",
			"xoxxxoxoxoxoooxox",
			"xoooooxoxoxxoxxox",
			"xoxxxxxoxooxoooox",
			"xoxoxoooxoxxxxxox",
			"xoxoooxoxoxoooxox",
			"xoxxxoxoxoooxoxox",
			"xoooooxoxoxoooxox",
			"xoxxoxxxxoxxoxxox",
			"xooxoxooxoxooooox",
			"xxxxoxxoxxxxoxxox",
		],
		"npc": [
			{
				"position": [6, 14],
				"direction": [1, 0]
			},
			{
				"position": [1, 16],
				"direction": [1, 0]
			},
			{
				"position": [1, 14],
				"direction": [0, -1]
			},
			{
				"position": [1, 6],
				"direction": [0, 1]
			},
			{
				"position": [3, 9],
				"direction": [0, 1]
			},
			{
				"position": [7, 4],
				"direction": [0, 1]
			},
			{
				"position": [7, 12],
				"direction": [0, -1]
			},
			{
				"position": [3, 5],
				"direction": [0, -1]
			},
			{
				"position": [9, 4],
				"direction": [1, 0]
			},
			{
				"position": [15, 4],
				"direction": [-1, 0]
			},
			{
				"position": [9, 6],
				"direction": [0, 1]
			},
			{
				"position": [9, 14],
				"direction": [0, -1]
			},
			{
				"position": [15, 6],
				"direction": [0, 1]
			},
			{
				"position": [15, 16],
				"direction": [0, -1]
			},
			{
				"position": [11, 10],
				"direction": [0, 1]
			},
			{
				"position": [11, 12],
				"direction": [1, 0]
			},
			{
				"position": [13, 12],
				"direction": [0, -1]
			},
			{
				"position": [13, 10],
				"direction": [-1, 0]
			},
			{
				"position": [10, 8],
				"direction": [-1, 0]
			},
		],
		"prop": [
			[9, 14],
			[7, 4],
		],
		"time": 30
	},
	11: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xxxxxoxxxxxxxxxox",
			"xoooxoxoxoxoooxox",
			"xoxxxoxoxoooxooox",
			"xoxoooxoxoxxxxxxx",
			"xoxxoxxoxooooooox",
			"xoxoooxoxxxxxoxox",
			"xoooxoooxoooxoxox",
			"xoxoooxoxoxooooox",
			"xoxxoxxoxoxoxxoxx",
			"xoxoooxxxoxooooxx",
			"xoxoxoooxoxoxxxxx",
			"xoxxxxxxxoxooxoox",
			"xoooxoooxxxxoooxx",
		],
		"npc": [
			{
				"position": [3, 4],
				"direction": [-1, 0]
			},
			{
				"position": [1, 16],
				"direction": [0, -1]
			},
			{
				"position": [3, 16],
				"direction": [1, 0]
			},
			{
				"position": [3, 13],
				"direction": [0, -1]
			},
			{
				"position": [7, 13],
				"direction": [-1, 0]
			},
			{
				"position": [3, 10],
				"direction": [1, 0]
			},
			{
				"position": [5, 10],
				"direction": [0, -1]
			},
			{
				"position": [5, 8],
				"direction": [-1, 0]
			},
			{
				"position": [3, 8],
				"direction": [0, 1]
			},
			{
				"position": [7, 11],
				"direction": [0, -1]
			},
			{
				"position": [7, 4],
				"direction": [0, 1]
			},
			{
				"position": [9, 5],
				"direction": [1, 0]
			},
			{
				"position": [9, 14],
				"direction": [0, -1]
			},
			{
				"position": [15, 14],
				"direction": [-1, 0]
			},
			{
				"position": [15, 16],
				"direction": [-1, 0]
			},
			{
				"position": [14, 12],
				"direction": [0, -1]
			},
			{
				"position": [15, 7],
				"direction": [0, -1]
			},
			{
				"position": [11, 9],
				"direction": [0, 1]
			},
		],
		"prop": [
			[3, 4],
			[7, 4],
			[9, 14],
		],
		"time": 30
	},
	12: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xoooxooogooooooox",
			"xoxxxxoxxxxxxxxox",
			"xoooooooxoooxooox",
			"xxoxxxxoxoxxxxoxx",
			"xoooxoooxooooooox",
			"xoxxxxxxxxoxxxxxx",
			"xoooooooxoooxooox",
			"xxxxxxxoxoxxxxoxx",
			"xoooooooxoooxooox",
			"xoxxxxxxxxoxxxxox",
			"xoooooooxooooooox",
			"xxoxxxxoxoxxxxxxx",
			"xoooxoooxooooooox",
			"xoxxxxoxxxxxxxxox",
		],
		"npc": [
			{
				"position": [3, 16],
				"direction": [-1, 0]
			},
			{
				"position": [3, 14],
				"direction": [-1, 0]
			},
			{
				"position": [5, 14],
				"direction": [1, 0]
			},
			{
				"position": [1, 12],
				"direction": [1, 0]
			},
			{
				"position": [7, 10],
				"direction": [-1, 0]
			},
			{
				"position": [1, 8],
				"direction": [1, 0]
			},
			{
				"position": [3, 6],
				"direction": [-1, 0]
			},
			{
				"position": [5, 6],
				"direction": [1, 0]
			},
			{
				"position": [3, 2],
				"direction": [-1, 0]
			},
			{
				"position": [15, 16],
				"direction": [-1, 0]
			},
			{
				"position": [9, 14],
				"direction": [1, 0]
			},
			{
				"position": [15, 12],
				"direction": [1, 0]
			},
			{
				"position": [13, 8],
				"direction": [1, 0]
			},
			{
				"position": [15, 8],
				"direction": [-1, 0]
			},
			{
				"position": [11, 10],
				"direction": [-1, 0]
			},
			{
				"position": [11, 8],
				"direction": [-1, 0]
			},
			{
				"position": [11, 4],
				"direction": [-1, 0]
			},
			{
				"position": [15, 6],
				"direction": [-1, 0]
			},
			{
				"position": [13, 4],
				"direction": [-1, 0]
			},
		],
		"prop": [
			[15, 8],
		],
		"time": 30
	},
	13: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xoxxxxxxxxxxxxxox",
			"xoooooxoxoxooooox",
			"xxxxxoooxoooxxxxx",
			"xoooooxoxoxooooox",
			"xoxxxxxxxxxxxxxox",
			"xoooooooooooooxox",
			"xxxxxxxxxxxxxoxox",
			"xoooooooooooooxox",
			"xoxxxxxxxxxxxxxox",
			"xoxooooooooooooox",
			"xoxoxxxxxxxxxxxxx",
			"xoxooooooooooooox",
			"xoxxxxxxxxxxxxxox",
		],
		"npc": [
			{
				"position": [1, 16],
				"direction": [1, 0]
			},
			{
				"position": [15, 16],
				"direction": [-1, 0]
			},
			{
				"position": [1, 10],
				"direction": [0, 1]
			},
			{
				"position": [13, 10],
				"direction": [-1, 0]
			},
			{
				"position": [1, 8],
				"direction": [1, 0]
			},
			{
				"position": [1, 2],
				"direction": [1, 0]
			},
			{
				"position": [7, 4],
				"direction": [0, 1]
			},
			{
				"position": [7, 6],
				"direction": [0, -1]
			},
			{
				"position": [9, 4],
				"direction": [0, 1]
			},
			{
				"position": [9, 6],
				"direction": [0, -1]
			},
			{
				"position": [15, 2],
				"direction": [-1, 0]
			},
			{
				"position": [3, 14],
				"direction": [1, 0]
			},
			{
				"position": [15, 12],
				"direction": [-1, 0]
			},
			{
				"position": [15, 6],
				"direction": [0, 1]
			},
			{
				"position": [1, 10],
				"direction": [1, 0]
			},
			{
				"position": [13, 8],
				"direction": [-1, 0]
			},
			{
				"position": [15, 14],
				"direction": [-1, 0]
			},
			{
				"position": [3, 12],
				"direction": [1, 0]
			},
			{
				"position": [15, 12],
				"direction": [0, -1]
			},
		],
		"prop": [
		],
		"time": 30
	},
	14: {
		"tiles": [
			"xxxxxxxxxxxxxxxxx",
			"xxxxxxxxxxxxxxxxx",
			"xooooooogooooooox",
			"xoxxxxxxxxxxxxxox",
			"xoxoooooxooxoooox",
			"xoxoxxxooxoooxxox",
			"xoxoooxxoooxooxox",
			"xoxxxooxxxooxooox",
			"xoooxxoooxxoooxox",
			"xxxooxxxooxxxooox",
			"xoooxxoxxoooxxxox",
			"xoxxxoooxxxoooxxx",
			"xoooxoxoooxxxooox",
			"xxxoxoxxxoxoxxxox",
			"xoooxoxoooooooxox",
			"xoxxxoxoxxxxxxxox",
		],
		"npc": [
			{
				"position": [11, 13],
				"direction": [0, 1]
			},
			{
				"position": [6, 10],
				"direction": [0, 1]
			},
			{
				"position": [5, 16],
				"direction": [0, -1]
			},
			{
				"position": [1, 16],
				"direction": [1, 0]
			},
			{
				"position": [3, 12],
				"direction": [0, 1]
			},
			{
				"position": [1, 14],
				"direction": [1, 0]
			},
			{
				"position": [1, 10],
				"direction": [1, 0]
			},
			{
				"position": [1, 10],
				"direction": [-1, 0]
			},
			{
				"position": [4, 9],
				"direction": [-1, 0]
			},
			{
				"position": [1, 8],
				"direction": [0, -1]
			},
			{
				"position": [1, 2],
				"direction": [0, 1]
			},
			{
				"position": [1, 2],
				"direction": [1, 0]
			},
			{
				"position": [15, 2],
				"direction": [-1, 0]
			},
			{
				"position": [15, 4],
				"direction": [-1, 0]
			},
			{
				"position": [15, 10],
				"direction": [0, -1]
			},
			{
				"position": [13, 6],
				"direction": [-1, 0]
			},
			{
				"position": [10, 7],
				"direction": [1, 0]
			},
			{
				"position": [8, 6],
				"direction": [1, 0]
			},
			{
				"position": [13, 9],
				"direction": [0, -1]
			},
			{
				"position": [7, 4],
				"direction": [-1, 0]
			},
			{
				"position": [3, 4],
				"direction": [1, 0]
			},
			{
				"position": [3, 6],
				"direction": [1, 0]
			},
			{
				"position": [6, 8],
				"direction": [1, 0]
			},
			{
				"position": [8, 9],
				"direction": [1, 0]
			},
			{
				"position": [9, 10],
				"direction": [1, 0]
			},
			{
				"position": [11, 11],
				"direction": [1, 0]
			},
			{
				"position": [13, 12],
				"direction": [1, 0]
			},
			{
				"position": [15, 12],
				"direction": [0, 1]
			},
			{
				"position": [15, 16],
				"direction": [0, 1]
			},
			{
				"position": [15, 16],
				"direction": [-1, 0]
			},
		],
		"prop": [
			[15, 10],
		],
		"time": 30
	},
	15: {
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
			{
				"position": [6, 11],
				"direction": [0, 1]
			}
		],
		"prop": [
		],
		"time": 30
	},
	16: {
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
			{
				"position": [6, 11],
				"direction": [0, 1]
			}
		],
		"prop": [
		],
		"time": 30
	},
}

const __TILEMAP_INDEX = {
	"x": 1,
	"o": 2,
	"g": 0
}

var level = 1
var alive_npcs = 0

func _ready()->void:
	Hud.visible = true
	PauseMenu.can_show = true
	load_level()
	# for row in range(16):
	# 	var rowstr = ""
	# 	for col in range(17):
	# 		var index = $TileMap.get_cell(col, row)
	# 		if index == 0:
	# 			rowstr += "g"
	# 		elif index == 1:
	# 			rowstr += "x"
	# 		elif index == 2:
	# 			rowstr += "o"
	# 	print('"' + rowstr + '",')

	# $ajbody.shortWeaponUnlocked = true
	# $rebody.shortWeaponUnlocked = true

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false


func _on_GoalArea_body_entered(body):
	if body.name == "rebody":
		re_has_reached_goal = true
	elif body.name == "ajbody":
		ai_has_reached_goal = true

	if re_has_reached_goal and ai_has_reached_goal:
		$rebody.reset_animation()
		$ajbody.reset_animation()
		get_tree().paused = true
		yield(get_tree().create_timer(2.0), "timeout")

		# TODO: show intermediate screen when unlocking item
		level_up()
		ScreenFade.state = ScreenFade.OUT
		if ScreenFade.state != ScreenFade.BLACK:
			yield(ScreenFade, "fade_complete")
		ScreenFade.state = ScreenFade.IN


func _on_GoalArea_body_exited(body):
	if body.name == "rebody":
		re_has_reached_goal = false
	elif body.name == "ajbody":
		ai_has_reached_goal = false

func _on_character_die():
	get_tree().paused = true
	yield(get_tree().create_timer(2.0), "timeout")

	Hud.life -= 1
	if Hud.life <= 0:
		Game.game_over()
		return

	ScreenFade.state = ScreenFade.OUT
	if ScreenFade.state != ScreenFade.BLACK:
		yield(ScreenFade, "fade_complete")
	ScreenFade.state = ScreenFade.IN

	load_level(false)

func level_up():
	level += 1
	if level > MAX_LEVEL:
		Game.win_game()
		return

	if level >= WEAPON_MIN_LEVEL:
		$rebody.shortWeaponUnlocked = true
		$ajbody.shortWeaponUnlocked = true

	load_level()


func load_level(is_new = true):
	var level_data = LEVEL_SETUP[level]

	# Load tiles
	var tiles = level_data["tiles"]
	for row in range(len(tiles)):
		for col in range(len(tiles[row])):
			var cell_index = __TILEMAP_INDEX[tiles[row][col]]
			$TileMap.set_cell(col, row, cell_index)

	# Delete current npc's and props
	for node in get_children():
		if "npc" in node.name or "prop" in node.name:
			node.queue_free()

	# Create new npc's
	var npc_scene = load(NPC_RESOURCE)
	var npc_data = level_data["npc"]
	for i in range(len(npc_data)):
		var npc_obj= npc_data[i]
		var npc = npc_scene.instance()
		add_child(npc, true)
		var npc_pos = npc_obj["position"]
		var npc_dir = npc_obj["direction"]
		npc.position = __get_tile_center(Vector2(npc_pos[0], npc_pos[1]))
		npc.direction = Vector2(npc_dir[0], npc_dir[1])
		npc.name = "npc" + str(i)
	alive_npcs = len(npc_data)

	# Create new props
	var prop_scene = load(PROP_RESOURCE)
	var prop_data = level_data["prop"]
	for i in range(len(prop_data)):
		var prop = prop_scene.instance()
		add_child(prop, true)
		var prop_pos = prop_data[i]
		prop.position = __get_tile_center(Vector2(prop_pos[0], prop_pos[1]))
		prop.name = "prop" + str(i)

	# Move re and ai to their start points
	$rebody.position = __get_tile_center(RE_START)
	$ajbody.position = __get_tile_center(AI_START)
	$rebody.reset_animation()
	$ajbody.reset_animation()
	$rebody.lastDirection = Vector2(0, 1)
	$ajbody.lastDirection = Vector2(0, 1)
	re_has_reached_goal = false
	ai_has_reached_goal = false

	# Time left
	if level == 1 and is_new:
		Hud.timeLeft = level_data["time"]
	elif is_new:
		Hud.timeLeft += level_data["time"]


	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().paused = false
	$TileMap.update_dirty_quadrants()


func __get_tile_center(tile_location_vector):
	var result = $TileMap.map_to_world(tile_location_vector)
	result.x += 8
	result.y += 8
	return result

func _on_eliminate_npc(pos: Vector2):
	alive_npcs -= 1
	if alive_npcs == 0:
		var prop_scene = load(PROP_RESOURCE)
		var prop = prop_scene.instance()
		prop.name = "propheartallkill"
		prop.type = "heart"
		add_child(prop)
		prop.position = pos


func _on_rebody_die():
	_on_character_die()


func _on_ajbody_die():
	_on_character_die()


func _on_rebody_eliminate_npc(pos: Vector2):
	_on_eliminate_npc(pos)


func _on_ajbody_eliminate_npc(pos: Vector2):
	_on_eliminate_npc(pos)
