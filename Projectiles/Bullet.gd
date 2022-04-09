extends KinematicBody2D

var collisionCount = 0
var direction = Vector2()
var velocity = Vector2()

export var bulletSpeed: float
export var maxCollisions: int
export(float, 0, 1) var reflectionAngle

onready var tracer = $Tracer
onready var impactSpawner = $Spawner


func _physics_process(delta):
	velocity = direction * bulletSpeed * delta
	
	var collision = move_and_collide(velocity)
	while collision:
		if tracer:
			tracer.forcePoint(global_position)
		
		
		# Process the reflection
		if abs(collision.normal.dot(direction)) < reflectionAngle:
			var reflectedRemainder = collision.remainder.bounce(collision.normal)
			increaseCollisionCount()
			collision = move_and_collide(reflectedRemainder)
			direction = reflectedRemainder.normalized()
		else:
			collision = impact(collision)
		
	

func impact(collision):
	var impact = impactSpawner.spawnToLevel()
	impact.rotation = collision.normal.angle()
	
	if is_instance_valid(get_node("DamageProfile")):
		var profile = get_node("DamageProfile")
		collision.collider.add_child(profile)
		profile.attemptApplyDamage(collision.collider)
	
	destroy()
	return null

func increaseCollisionCount():
	collisionCount += 1
	if collisionCount > maxCollisions:
		destroy()

func finishSetup():
	if tracer:
		tracer.forcePoint(global_position)


func destroy():
	if is_instance_valid(tracer):
		tracer.forcePoint(global_position)
		var tracerLastPosition = tracer.global_position
		remove_child(tracer)
		GlobalReference.level.add_child(tracer)
		tracer.global_position = tracerLastPosition
		tracer.destroy()
	queue_free()


func _on_Expiry_timeout():
	self.queue_free()
	pass
