extends Generic6DOFJoint3D

func _physics_process(delta: float) -> void:
	var test = get_node(node_b).transform.affine_inverse() * self.global_transform
	print(rad_to_deg(test.basis.get_euler().x))
	print(rad_to_deg(test.basis.get_euler().y))
	print(rad_to_deg(test.basis.get_euler().z))

	set("angular_motor_x/target_velocity", deg_to_rad(30))
