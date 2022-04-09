extends "res://Parts/Weapon/Weapon.gd"

onready var timer = $Firespeed
onready var bulletSpawner = $BulletSpawner
onready var damageProfileSpawner = $DamageProfileSpawner
onready var sprite = $AnimatedSprite
onready var terrainRay = $RayCast2D

var canFire = true
var isFiring = false

func _process(delta):
	aimToTarget()
	
	if isFiring and canFire and !terrainRay.is_colliding():
		fire()
		canFire = false


func fire_pressed():
	.fire_pressed()
	isFiring = true


func fire_released():
	.fire_released()
	isFiring = false


func fire():
	sprite.frame = 0
	sprite.play("default")
	var bullet = genericFire(bulletSpawner, damageProfileSpawner)
	timer.start()


func _on_Timer_timeout():
	canFire = true

