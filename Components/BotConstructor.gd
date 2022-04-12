extends Node
class_name BotConstructor


var rng
export var botScene: PackedScene


func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()


class botBlueprint:
	var armor
	var legs
	#var weapons
	var controller


func chooseItem(dict):
	return dict[dict.keys()[rng.randi_range(0, dict.size() - 1)]]


func generateRandomBlueprint():
	var newBlueprint = botBlueprint.new()
	newBlueprint.armor = chooseItem(EquipmentList.armors)
	#newBlueprint.weapons = chooseItem(EquipmentList.weapons)
	newBlueprint.legs = chooseItem(EquipmentList.legs)
	return newBlueprint


func createWeapon(weaponPath):
	var weaponScene = load(weaponPath)
	var weaponInstance = weaponScene.instance()
	return weaponInstance


func createBotWithBlueprint(blueprint):
	var newBot = botScene.instance()
	
	var armorScene = load(blueprint.armor)
	var legsScene = load(blueprint.legs)
	var controllerScene = load(blueprint.controller)
	
	var armorInstance = armorScene.instance()
	var legsInstance = legsScene.instance()
	var controllerInstance = controllerScene.instance()
	
	newBot.add_child(armorInstance)
	newBot.add_child(legsInstance)
	newBot.add_child(controllerInstance)
	
	armorInstance.owner = newBot
	legsInstance.owner = newBot
	controllerInstance.owner = newBot
	
	return newBot


func createPlayer(newPlayerBlueprint):
	var newPlayer
	var playerBlueprint = generateRandomBlueprint()
	playerBlueprint.controller = EquipmentList.playerControllers["game"]
	newPlayer = createBotWithBlueprint(playerBlueprint)
	var newWeapon = createWeapon(EquipmentList.weapons["atg"])
	newPlayer.call_deferred("equipWeapon", newWeapon, armor.SLOT_TYPE.PRIMARY)
	return newPlayer
