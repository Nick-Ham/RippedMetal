extends enemy_base_controller

var path = []
var completedPath = []
var completedPathMaxLength = 5
var navigation = null
var thresholdSquared = 1300
var targetFollowDistanceSquared = 25000
var hasLineOfSight = false
var circlingTimeScalar = 1000

onready var lineOfSight = $LineOfSight
onready var navPathLine = $Node/NavPathLine
onready var completedPathLine = $Node/CompletedPathLine

class chaseControllerState:
	var target = null
	func setTarget(target):
		self.target = target
	func stateProcess(delta):
		pass
	func statePhysicsProcess(delta):
		pass

onready var states = {
	"noTargetIdle":funcref(self, "stateNoTargetIdle"),
	"moveToTarget":funcref(self, "stateMoveToTarget"),
	"nearToTargetNoCover":funcref(self, "stateNearToTargetNoCover"),
	"moveToCover":funcref(self, "stateMoveToCover"),
	"nearToTargetWithCover":funcref(self, "stateNearToTargetWithCover")
}

var currentState

func _ready():
	yield(owner, "ready")
	lineOfSight.add_exception(owner)
	#lineOfSight.enabled = false
	currentState = "noTargetIdle"


func _process(delta):
	if acquiredTarget:
		targetGlobalPosition = acquiredTarget.global_position


func _physics_process(delta):
	if acquiredTarget:
		lineOfSight.cast_to = to_local(acquiredTarget.global_position)
	var newState = states[currentState].call_func(delta)
	if newState != null && newState != currentState:
		currentState = newState
	#print(currentState)


func stateNoTargetIdle(delta):
	direction = Vector2()
	if acquiredTarget:
		return "moveToTarget"


func stateMoveToTarget(delta):
	if acquiredTarget:
		
		
		if !lineOfSight.is_colliding():
			return "moveToCover"
		
		if path.size() > 0:
			if acquiredTarget.global_position.distance_squared_to(global_position) > targetFollowDistanceSquared:
				if global_position.distance_squared_to(path[0]) > thresholdSquared:
					direction = global_position.direction_to(path[0])
				else:
					completedPath.push_front(path[0])
					path.remove(0)
					if completedPath.size() > completedPathMaxLength:
						completedPath.pop_back()
					
					completedPathLine.points = completedPath
			else:
				return "nearToTargetNoCover"
	else:
		return "noTargetIdle"


func stateNearToTargetNoCover(delta):
	direction = Vector2()
	if acquiredTarget:
		if global_position.distance_squared_to(acquiredTarget.global_position) > targetFollowDistanceSquared:
			return "moveToTarget"
		if lineOfSight.is_colliding():
			return "nearToTargetWithCover"
		


func stateNearToTargetWithCover(delta):
	direction = Vector2()
	if acquiredTarget:
		if global_position.distance_squared_to(acquiredTarget.global_position) > targetFollowDistanceSquared:
			return "moveToTarget"
		if !lineOfSight.is_colliding():
			return "nearToTargetNoCover"
		if path.size() > 0:
			if global_position.distance_squared_to(path[0]) > thresholdSquared:
				direction = global_position.direction_to(path[0])
			else:
				completedPath.push_front(path[0])
				path.remove(0)
				if completedPath.size() > completedPathMaxLength:
					completedPath.pop_back()
				
				completedPathLine.points = completedPath


func stateMoveToCover(delta):
	direction = Vector2()
	if acquiredTarget.global_position.distance_squared_to(global_position) < targetFollowDistanceSquared:
		if lineOfSight.is_colliding():
			return "nearToTargetWithCover"
		else:
			return "nearToTargetNoCover"
	if completedPath.size() > 0:
		direction = global_position.direction_to(completedPath[0])
		if global_position.distance_squared_to(completedPath[0]) < thresholdSquared:
			return "moveToTarget"
	else:
		return "moveToTarget"


func onBodyDetected(body):
	if !acquiredTarget:
		acquiredTarget = body


func onBodyLost(body):
	if body == acquiredTarget:
		acquiredTarget = null


func getNavPath(target):
	if is_instance_valid(GlobalReference.level.navigation):
		path = GlobalReference.level.navigation.get_simple_path(global_position, target.global_position, true)
		
		navPathLine.points = path


func _on_NavCalculationTick_timeout():
	if acquiredTarget:
		getNavPath(acquiredTarget)
