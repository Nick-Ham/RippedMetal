extends Node2D
class_name spawner

export(bool) var persistent = false
export var sceneToSpawn: PackedScene
var instancedScene

func spawnToLevel():
	instancedScene = sceneToSpawn.instance()
	instancedScene.global_position = global_position
	GlobalReference.level.add_child(instancedScene)
	return instancedScene

func spawn():
	instancedScene = sceneToSpawn.instance()
	return instancedScene

func _on_Timer_timeout():
	if is_instance_valid(instancedScene) and !persistent:
		instancedScene.queue_free()
		
