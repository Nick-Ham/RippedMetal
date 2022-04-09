extends Node2D

onready var camera = $Camera2D

func _physics_process(delta):
	
	var targetPosition = Vector2()
	
	if GlobalReference.player:
		targetPosition = lerp(GlobalReference.player.global_position, get_global_mouse_position(), .2)
		camera.global_position = lerp(camera.global_position, targetPosition, .1)
