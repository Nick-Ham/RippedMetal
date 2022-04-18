extends enemy_base_controller

var path = []
var navigation = null
var thresholdSquared = 144


func onBodyDetected(body):
	if !acquiredTarget:
		acquiredTarget = body


func onBodyLost(body):
	if body == acquiredTarget:
		acquiredTarget = null


func _process(delta):
	if acquiredTarget:
		targetGlobalPosition = acquiredTarget.global_position


func _physics_process(delta):
	if path.size() > 0:
		moveToTarget()


func moveToTarget():
	if global_position.distance_squared_to(path[0]) < thresholdSquared:
		path.remove(0)
	else:
		direction = global_position.direction_to(path[0])


func getNavPath(target):
	if is_instance_valid(GlobalReference.level.navigation):
		path = GlobalReference.level.navigation.get_simple_path(global_position, target.global_position, true)
		$Node/Line2D.points = path


func _on_NavCalculationTick_timeout():
	if acquiredTarget:
		getNavPath(acquiredTarget)
