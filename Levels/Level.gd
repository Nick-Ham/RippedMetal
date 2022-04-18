extends Node
class_name level

onready var botConstructor = $BotConstructor
onready var playerCamera = $PlayerCamera
onready var playerSpawn = $PlayerSpawn
onready var navigation = $Navigation2D

var playerBot

func setupLevel():
	setupPlayer()


func setupPlayer():
	playerBot = botConstructor.createPlayer(botConstructor.generateRandomBlueprint())
	add_child(playerBot)
	playerBot.global_position = playerSpawn.global_position
	GlobalReference.player = playerBot
	playerCamera.global_position = playerBot.global_position


func beginLevel():
	for each in get_children():
		if each is bot:
			each.activate()
	
