extends RigidBody3D

@export
var targets: Array[Node3D]

@export_enum("1", "2", "3") var selected: int

@export
var p_gain: float

func _physics_process(delta: float) -> void:
	var error: float =  self.position.x - targets[selected].position.x
	var p: float= p_gain * error;
	error = clampf(error, -1, 1)
	
	apply_force(Vector3(-error * 10, 0, 0))
	print(error)
