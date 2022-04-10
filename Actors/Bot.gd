extends KinematicBody2D
class_name bot

var direction = Vector2()
var velocity = Vector2()
var targetGlobalPosition = Vector2()

onready var controller = $Controller
onready var legs = $Legs
onready var armor = $Armor

func _ready():
	if is_instance_valid(controller):
		controller.connectSignalsToTarget(self)
		controller.connectSignalsToTarget(armor)
	else:
		print("Bot.gd: Controller not found, bot will not function properly.")


func _process(delta):
	direction = Vector2()
	targetGlobalPosition = Vector2()
	
	if is_instance_valid(controller):
		direction = controller.direction
		targetGlobalPosition = controller.targetGlobalPosition

func _physics_process(delta):
	var collision = move_and_collide(velocity)
	

func activate():
	if is_instance_valid(controller):
		controller.activate()

func destroy():
	controller.deactivate()



# Unused for now
func _on_primary_pressed():
	pass

func _on_primary_released():
	pass

func _on_secondary_pressed():
	pass

func _on_secondary_released():
	pass
