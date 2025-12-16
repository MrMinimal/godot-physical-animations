extends Generic6DOFJoint3D
@onready var marker_3d: Marker3D = $Marker3D

const P_GAIN = 100
const D_GAIN = 5000
const I_GAIN = -500

var errorLast = 0
var integration_stored = 0

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
	
	# TODO change to valueLast/velocity according to vazgriz to prevent derivative kick
	var errorRateOfChange = (error.x - errorLast)
	errorLast = error.x
	var D = D_GAIN * errorRateOfChange
	self.integration_stored = self.integration_stored + error.x;
	var I = I_GAIN * self.integration_stored;

	if P > 0:
		set("angular_motor_x/target_velocity", 2000)
	else:
		set("angular_motor_x/target_velocity", -2000)
	set("angular_motor_x/force_limit", abs(P + D + I))
	print(P)
