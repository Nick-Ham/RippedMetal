extends Node2D

var targetGlobalPosition = Vector2()

var ownerBot

var isFiring = false
var justFired = false

func fire_pressed():
	isFiring = true
	justFired = true
	pass

func fire_released():
	isFiring = false
	pass

func aimToTarget():
	look_at(targetGlobalPosition)
	if abs(rotation) > .2:
		if rotation > 0:
			rotation = .2
		else:
			rotation = -.2


func genericFire(bulletSpawner, damageProfileSpawner):
	justFired = false
	var bullet = bulletSpawner.spawnToLevel()
	bullet.add_collision_exception_with(ownerBot)
	bullet.direction = Vector2(1,0).rotated(global_rotation)
	bullet.finishSetup()
	var damageProfile = damageProfileSpawner.spawn()
	bullet.add_child(damageProfile)
	return bullet
