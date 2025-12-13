extends PhysicalBone3D

func _ready() -> void:
	print()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_SPACE:
			apply_impulse(Vector3.RIGHT * 0.01, Vector3(0, 5, 0) * 20)
