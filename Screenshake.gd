extends Node
class_name screenshake

var trauma = 0
var traumaPower = 2

export var traumaDecay = 2
export var maxOffset = Vector2(100, 75)
export var maxRotation = .1


func _ready():
	randomize()
	GlobalReference.screenshake = self


func _process(delta):
	if trauma > 0:
		trauma -= traumaDecay * delta
	trauma = clamp(trauma, 0, 1)


func addTrauma(addedTrauma):
	trauma += addedTrauma
	trauma = clamp(trauma, 0, 1)
