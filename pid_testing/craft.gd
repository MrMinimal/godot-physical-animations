extends RigidBody3D

const MAX_FORCE = 10

@export
var targets: Array[Node3D]

@export_enum("1", "2", "3")
var selected: int

var pFactor = 1
var iFactor = 0
var dFactor = 20

var lastError = 0
var integralActiveZone = 50


func _physics_process(delta: float) -> void:
	var R = self.position.x
	var Y = targets[selected].position.x
	var kp = 0
	var ki = 0
	var kd = 0
	var time = delta
	var currentError = R - Y
	
	if (currentError != 0):
		kp = currentError * pFactor
		ki = iFactor + currentError * pFactor
	else:
		ki = 0
		kp = 0
 
	if (currentError != 0):
		kd = ((currentError - lastError)) * dFactor
	else:
		kd = 0
	lastError = currentError
	var out = kp + ki + kd
	
	apply_force(Vector3(-out * MAX_FORCE, 0, 0))
