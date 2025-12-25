extends RigidBody3D

const MAX_FORCE = 50

@export
var targets: Array[Node3D]

@export_enum("1", "2", "3", "4", "5")
var selected: int

@onready
var controller = PidController.new()

func _physics_process(delta: float) -> void:
	var out = controller.update(delta, self.position.y, targets[selected].position.y)
	
	apply_force(Vector3(0, out * MAX_FORCE, 0))
