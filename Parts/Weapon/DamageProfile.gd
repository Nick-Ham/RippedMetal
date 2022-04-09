extends Node
class_name DamageProfile

export (float, 0, 10000) var damage 


func attemptApplyDamage(target):
	if is_instance_valid(target.get_node("Health")):
		target.get_node("Health").damageHealth(damage)
	
	queue_free()
