extends Node2D

signal NewGame		#You choose how to use it
signal Continue		#You choose how to use it
signal Resume		#You choose how to use it
signal Restart		#Reloads current scene
signal ChangeScene	#Pass location of next scene file
signal Exit			#Triggers closing the game

onready var CurrentScene = null
var NextScene

var loader: = ResourceAsyncLoader.new()

func _ready()->void:
	connect("Exit",			self, "on_Exit")
	connect("ChangeScene",	self, "on_ChangeScene")
	connect("Restart", 		self, "restart_scene")

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
	get_node("/root/MainMenu/BG/GameContainer/TitleScreenContainer").visible = false
	gameContainer.add_child(CurrentScene.instance(), true)

func restart_scene()->void:
	if ScreenFade.state != ScreenFade.IDLE:
		return
	get_tree().reload_current_scene()


func on_Exit()->void:
	if ScreenFade.state != ScreenFade.IDLE:
		return
	get_tree().quit()
	
# Gameplay

func take_life():
	var curr = Hud.life
	var new = curr - 1
	Hud.life = new
	if new <= 0:
		game_over()

func time_is_up():
	game_over()

func game_over():
	print("GAME OVER")
	#TODO
