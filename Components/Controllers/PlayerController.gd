extends "res://Components/Controllers/Controller.gd"

func _process(delta):
	direction = Vector2()
	
	if controllerActive:
		if Input.is_action_pressed("up"):
			direction.y -= 1
		if Input.is_action_pressed("down"):
			direction.y += 1
		if Input.is_action_pressed("left"):
			direction.x -= 1
		if Input.is_action_pressed("right"):
			direction.x += 1
		direction = direction.normalized()
		
		
		if Input.is_action_just_pressed("primary_use"):
			emit_signal("primary_pressed")
		if Input.is_action_just_released("primary_use"):
			emit_signal("primary_released")
		
		targetGlobalPosition = get_global_mouse_position() 
		
	

