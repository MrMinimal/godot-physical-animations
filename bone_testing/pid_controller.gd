extends Generic6DOFJoint3D
@onready var marker_3d: Marker3D = $Marker3D

func _physics_process(delta: float) -> void:
	# Convert basis to quaternion, keep in mind scale is lost
	var a = Quaternion(marker_3d.basis)
	var b = Quaternion(get_node(node_b).basis)
	# Interpolate using spherical-linear interpolation (SLERP).
	#var c = a.slerp(b, 0.2)
	var offset = b * a.inverse()
	
	var output: Vector3 = Vector3(
		rad_to_deg(offset.get_euler().x),
		rad_to_deg(offset.get_euler().y),
		rad_to_deg(offset.get_euler().z),
	)
	print(output)

	if offset.x > 0:
		set("angular_motor_x/target_velocity", 1)
	else:
		set("angular_motor_x/target_velocity", -1)
