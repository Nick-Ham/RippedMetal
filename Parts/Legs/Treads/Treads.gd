extends legs

onready var sprite = $Base
onready var treadsL = $Base/TreadsL
onready var treadsR = $Base/TreadsR
onready var treadTrailL = $Base/TreadTrailL
onready var treadTrailR = $Base/TreadTrailR


func updateLegs():
	if velocity.length_squared() > .1:
		sprite.rotation = velocity.angle_to_point(Vector2())
		treadTrailL.emitting = true
		treadTrailR.emitting = true
	else:
		treadTrailL.emitting = false
		treadTrailR.emitting = false
	
	var newSpeedScale = velocity.length() / speedHardCap
	if newSpeedScale > .1:
		newSpeedScale += .1
	else:
		newSpeedScale = 0
	treadsL.speed_scale = newSpeedScale
	treadsR.speed_scale = newSpeedScale
	
