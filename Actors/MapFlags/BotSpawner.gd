extends Node2D

onready var sprite = $Sprite
onready var botConstructor = $BotConstructor
export(bool) var randomLoadout = true

var newBot

func _ready():
	sprite.visible = false
	if randomLoadout:
		spawnRandomBot()

func spawnRandomBot():
	var newBotBlueprint = botConstructor.generateRandomBlueprint()
	newBotBlueprint.controller = EquipmentList.aiControllers["testController"]
	newBot = botConstructor.createBotWithBlueprint(newBotBlueprint)
	newBot.global_position = self.global_position
	get_parent().call_deferred("add_child", newBot)

func _process(delta):
	pass
