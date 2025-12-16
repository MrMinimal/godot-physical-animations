extends Generic6DOFJoint3D
@onready var marker_3d: Marker3D = $Marker3D

const P_GAIN = 1000
const D_GAIN = 5000

var errorLast = 0

func _physics_process(delta: float) -> void:
	# Convert basis to quaternion, keep in mind scale is lost
	var a = Quaternion(marker_3d.basis)
	var b = Quaternion(get_node(node_b).basis)
	# Interpolate using spherical-linear interpolation (SLERP).
	#var c = a.slerp(b, 0.2)
	var error = b * a.inverse()
	
	var output: Vector3 = Vector3(
		rad_to_deg(error.get_euler().x),
		rad_to_deg(error.get_euler().y),
		rad_to_deg(error.get_euler().z),
	)
	#print(output)

	var P = P_GAIN * error.x
	
	var errorRateOfChange = (error.x - errorLast)
	errorLast = error.x
	var D = D_GAIN * errorRateOfChange

	if P > 0:
		set("angular_motor_x/target_velocity", 2000)
	else:
		set("angular_motor_x/target_velocity", -2000)
	set("angular_motor_x/force_limit", abs(P + D))
	print(P)
