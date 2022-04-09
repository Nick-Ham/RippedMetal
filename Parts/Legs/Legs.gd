extends Node2D

export(float) var acceleration = 25
export(float) var speedSoftCap = 7
export(float) var speedHardCap = 10

var direction = Vector2()
var velocity = Vector2()

func _process(delta):
	direction = owner.direction
	updateLegs()

func _physics_process(delta):
	direction = owner.direction
	direction = direction.normalized()
	velocity += direction * acceleration * delta
	
	if velocity.length() > speedSoftCap:
		if velocity.length() > speedHardCap:
			velocity = velocity.normalized() * speedHardCap
		else:
			velocity *= .9
	velocity *= .9
	
	owner.velocity = velocity


func updateLegs():
	pass
