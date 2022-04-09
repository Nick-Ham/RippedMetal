extends Node2D
class_name controller

var controllerActive = false
var direction = Vector2()
var targetGlobalPosition = Vector2()

signal primary_pressed
signal primary_released
signal secondary_pressed
signal secondary_released

func connectSignalsToTarget(target):
	connect("primary_pressed", target, "_on_primary_pressed")
	connect("primary_released", target, "_on_primary_released")
	connect("secondary_pressed", target, "_on_secondary_pressed")
	connect("secondary_released", target, "_on_secondary_released")


func activate():
	controllerActive = true


func deactivate():
	controllerActive = false
	emit_signal("primary_released")
	emit_signal("secondary_released")
