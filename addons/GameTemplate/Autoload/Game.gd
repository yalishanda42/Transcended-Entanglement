extends Node2D

signal NewGame		#You choose how to use it
signal Continue		#You choose how to use it
signal Resume		#You choose how to use it
signal MainMenu
signal Restart		#Reloads game
signal ChangeScene	#Pass location of next scene file
signal Exit			#Triggers closing the game

signal current_instance_changed

onready var CurrentScene = null
var CurrentSceneInstance = null
var NextScene

var loader: = ResourceAsyncLoader.new()

func _ready()->void:
	connect("Exit",			self, "on_Exit")
	connect("ChangeScene",	self, "on_ChangeScene")
	connect("Restart", 		self, "restart_level")
	connect("NewGame",		self, "start_over")
	connect("MainMenu",		self, "restart_scene")

func on_ChangeScene(scene)->void:
	if ScreenFade.state != ScreenFade.IDLE:
		return
	ScreenFade.state = ScreenFade.OUT
	if loader.can_async:
		NextScene = yield(loader.load_start( [scene] ), "completed")[0]				#Using ResourceAsyncLoader to load in next scene - it takes in array list and gives back array
	else:
		NextScene = loader.load_start( [scene] )
	if NextScene == null:
		print(' Game.gd 36 - Loaded.resource is null')
		return
	if ScreenFade.state != ScreenFade.BLACK:
		yield(ScreenFade, "fade_complete")
	switch_scene()
	ScreenFade.state = ScreenFade.IN

func switch_scene()->void: 														#handles actual scene change
	CurrentScene = NextScene
	NextScene = null
	#get_tree().change_scene_to(CurrentScene)
	if typeof(CurrentScene) == TYPE_ARRAY:
		CurrentScene = CurrentScene[0]
	var gameContainer = get_node("/root/MainMenu/BG/GameContainer")
	var toRemove = gameContainer.get_children()[0]
	gameContainer.remove_child(toRemove)
	toRemove.queue_free()
	CurrentSceneInstance = CurrentScene.instance()
	emit_signal("current_instance_changed")
	gameContainer.add_child(CurrentSceneInstance, true)

func restart_scene()->void:
	if ScreenFade.state != ScreenFade.IDLE:
		return
	get_tree().reload_current_scene()


func on_Exit()->void:
	if ScreenFade.state != ScreenFade.IDLE:
		return
	get_tree().quit()

# Gameplay

func start_over():
	Hud.life = 1
	on_ChangeScene("res://Levels/level.tscn")

func time_is_up():
	game_over()
	yield(self, "current_instance_changed")
	CurrentSceneInstance.is_time = true

func game_over():
	on_ChangeScene("res://MainMenu/GameOverContainer.tscn")
	

func win_game():
	on_ChangeScene("res://MainMenu/WinGameContainer.tscn")
