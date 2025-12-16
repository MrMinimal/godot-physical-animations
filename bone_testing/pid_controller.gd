extends Generic6DOFJoint3D
@onready var marker_3d: Marker3D = $"../../../../Marker3D"

func _physics_process(delta: float) -> void:
	var test = get_node(node_b).transform.affine_inverse() * self.global_transform
	#print(rad_to_deg(test.basis.get_euler().x))
	#print(rad_to_deg(test.basis.get_euler().y))
	#print(rad_to_deg(test.basis.get_euler().z))
	
		# Convert basis to quaternion, keep in mind scale is lost
	var a = Quaternion(marker_3d.basis)
	var b = Quaternion(get_node(node_b).basis)
	# Interpolate using spherical-linear interpolation (SLERP).
	#var c = a.slerp(b, 0.2)
	var offset = b * a.inverse()
	
	print(offset.get_euler()) # in radians

	set("angular_motor_x/target_velocity", offset.x * 5)
