extends KinematicBody2D
class_name armor

export(int) var socketCount

enum SLOT_TYPE {PRIMARY, SECONDARY}

var primarySocketedWeapons = []
var secondarySocketedWeapons = []

onready var sockets = $Sockets
onready var primarySockets = sockets.get_node("PrimarySockets")
onready var secondarySockets = sockets.get_node("SecondarySockets")

func _ready():
	equipFromScene()
	

func _process(delta):
	rotation = owner.targetGlobalPosition.angle_to_point(global_position)
	for each in primarySocketedWeapons:
		each.targetGlobalPosition = owner.targetGlobalPosition
	for each in secondarySocketedWeapons:
		each.targetGlobalPosition = owner.targetGlobalPosition


func equipFromScene():
	for each in primarySockets.get_children():
		if each.get_child_count() > 0:
			equipWeapon(each.get_children()[0], SLOT_TYPE.PRIMARY)
	

func equipWeapon(weapon, slotType):
	if slotType == SLOT_TYPE.PRIMARY:
		primarySocketedWeapons.append(weapon)
		weapon.ownerBot = owner
		weapon.transform.y *= -1
	if slotType == SLOT_TYPE.SECONDARY:
		secondarySocketedWeapons.append(weapon)
		weapon.ownerBot = owner
	

func _on_primary_pressed():
	for each in primarySocketedWeapons:
		each.fire_pressed()
	pass

func _on_primary_released():
	for each in primarySocketedWeapons:
		each.fire_released()
	pass

func _on_secondary_pressed():
	pass

func _on_secondary_released():
	pass


func destroy():
	owner.destroy()
	
