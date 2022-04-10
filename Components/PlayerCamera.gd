extends Node2D

onready var camera = $Camera2D
export(float) var screenRatioBiasScalar
export(float) var screenShiftScalar


func _physics_process(delta):
	
	var targetPosition = Vector2()
	
	if GlobalReference.player:
		var mouseDifference = get_global_mouse_position() - GlobalReference.player.global_position
		mouseDifference *= screenShiftScalar
		mouseDifference *= Vector2(1,1) + (getScreenSizeBias() * screenRatioBiasScalar)
		var playerGlobalPosition = GlobalReference.player.global_position
		targetPosition = lerp(playerGlobalPosition, playerGlobalPosition + mouseDifference, .2)
		camera.global_position = lerp(camera.global_position, targetPosition, .1)
	


func getScreenSizeBias():
	var windowSize = OS.get_window_size()
	var screenSizeBias = Vector2()
	screenSizeBias.x = windowSize.y/windowSize.x
	screenSizeBias.y = windowSize.x/windowSize.y
	return screenSizeBias

