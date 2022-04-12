extends "res://Parts/Weapon/Weapon.gd"

onready var timer = $Firespeed
onready var bulletSpawner = $BulletSpawner
onready var damageProfileSpawner = $DamageProfileSpawner
onready var gunSprite = $Gun
onready var firingConeSprite = $FiringCone
onready var terrainRay = $RayCast2D

var canFire = true

func _process(delta):
	aimToTarget()
	
	if (isFiring or justFired) and canFire and !terrainRay.is_colliding():
		fire()
		canFire = false


func fire_pressed():
	.fire_pressed()
	isFiring = true


func fire_released():
	.fire_released()
	isFiring = false


func fire():
	gunSprite.frame = 0
	gunSprite.play("default")
	firingConeSprite.visible = true
	firingConeSprite.frame = 0
	firingConeSprite.play("default")
	var bullet = genericFire(bulletSpawner, damageProfileSpawner)
	timer.start()


func _on_Timer_timeout():
	canFire = true


func _on_FiringCone_animation_finished():
	firingConeSprite.visible = false

