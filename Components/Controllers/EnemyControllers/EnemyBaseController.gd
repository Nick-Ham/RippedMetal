extends controller
class_name enemy_base_controller

onready var detector = $Detector


var detectedBots = []
var acquiredTarget = null


func onBodyDetected(body):
	pass


func onBodyLost(body):
	pass


func _on_Detector_body_entered(body):
	if !(body in detectedBots) and (body != owner):
		detectedBots.append(body)
		onBodyDetected(body)


func _on_Detector_body_exited(body):
	if body in detectedBots:
		detectedBots.erase(body)
		onBodyLost(body)
