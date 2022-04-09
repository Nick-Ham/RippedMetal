extends Node
class_name Health

export var maxHealth = 100
export var minHealth = 0


var health = maxHealth

func addOwner(var newOwner):
	owner = newOwner

func damageHealth(var incomingDamage):
	health -= incomingDamage
	determineStatus()

func determineStatus():
	if health <= minHealth:
		destroy()

func destroy():
	if owner:
		if owner.has_method("destroy"):
			owner.destroy()
	
	queue_free()
