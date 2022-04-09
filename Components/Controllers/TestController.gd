extends controller

var accumulator = 0

func _process(delta):
	direction = Vector2()
	
	if controllerActive:
		var timeScaled = OS.get_ticks_msec() * .002
		var targetOffset = Vector2(sin(timeScaled + PI/2.0), sin(timeScaled)) * 100.0
		if is_instance_valid(GlobalReference.player):
			targetGlobalPosition = GlobalReference.player.global_position #owner.global_position + targetOffset
		
		direction = Vector2(sin(timeScaled + PI/2), sin(timeScaled)) 
		
		accumulator += delta
		if accumulator > 1.0:
			accumulator -= 1.0
			#emit_signal("primary_pressed")
		
