extends Node

onready var levelSpawner = $Spawner
onready var botConstructor = $BotConstructor

func _ready():
	var level = createLevel()


func createLevel():
	var level = levelSpawner.spawn()
	add_child(level)
	GlobalReference.level = level
	level.setupLevel()
	return level


func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()


func _on_Gamestart_timeout():
	GlobalReference.level.beginLevel()

