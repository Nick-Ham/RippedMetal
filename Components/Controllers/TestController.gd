extends controller

export(float) var reactionTime = .5

onready var raycast = $RayCast2D
var accumulator = 0

func _process(delta):
	direction = Vector2()
	
	if controllerActive:
		var timeScaled = OS.get_ticks_msec() * .002
		var targetOffset = Vector2(sin(timeScaled + PI/2.0), sin(timeScaled)) * 100.0
		if is_instance_valid(GlobalReference.player):
			targetGlobalPosition = GlobalReference.player.global_position #owner.global_position + targetOffset
		
		raycast.cast_to = to_local(targetGlobalPosition)
		
		
		direction = Vector2(sin(timeScaled + PI/2), sin(timeScaled)) 
		
		
		if hasLineOfSight():
			accumulator += delta
		else:
			accumulator = 0
		
		if accumulator >= reactionTime:
			emit_signal("primary_pressed")
			emit_signal("primary_released")


func hasLineOfSight():
	return !raycast.is_colliding()

