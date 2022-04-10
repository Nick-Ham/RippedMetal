extends Node
class_name level

onready var botConstructor = $BotConstructor
onready var playerCamera = $PlayerCamera
onready var playerSpawn = $PlayerSpawn

var playerBot

func setupLevel():
	createPlayer()

func beginLevel():
	for each in get_children():
		if each is bot:
			each.activate()
	

func createPlayer():
	var playerBlueprint = botConstructor.generateRandomBlueprint()
	playerBlueprint.controller = EquipmentList.playerControllers["game"]
	playerBot = botConstructor.createBotWithBlueprint(playerBlueprint)
	playerBot.global_position = playerSpawn.global_position
	add_child(playerBot)
	GlobalReference.player = playerBot
	
	
