extends Node2D

var destroyed = false
var segmentsSinceDestroyed = 0
onready var line = $Decoupler/Line2D
export var tracerLength: float
export var tracerWidth: int


func _ready():
	line.clear_points()
	line.width = tracerWidth


func _physics_process(delta):
	line.add_point(global_position)
	while line.get_point_count() > (tracerLength):
		line.remove_point(0)
	
	if destroyed:
		segmentsSinceDestroyed += 1.0
		if segmentsSinceDestroyed >= tracerLength:
			queue_free()


func forcePoint(globalPositionOfPoint):
	line.add_point(globalPositionOfPoint)


func destroy():
	destroyed = true
