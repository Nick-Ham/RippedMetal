extends legs

onready var sprite = $Base
onready var treadsL = $Base/TreadsL
onready var treadsR = $Base/TreadsR

func updateLegs():
	if velocity.length_squared() > .1:
		sprite.rotation = velocity.angle_to_point(Vector2())
	var newSpeedScale = velocity.length() / speedHardCap
	if newSpeedScale > .1:
		newSpeedScale += .1
	else:
		newSpeedScale = 0
	treadsL.speed_scale = newSpeedScale
	treadsR.speed_scale = newSpeedScale
	
