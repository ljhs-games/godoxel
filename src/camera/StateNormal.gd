extends Node

const camera_controller_type = preload("res://camera/CameraController.gd")

var zoom_speed: float setget ,_get_zoom_speed
var zoom_dir: Vector3 setget ,_get_zoom_dir
onready var context: camera_controller_type = get_parent()

func into():
	pass
#	Input.set_default_cursor_shape(Input.CURSOR_IBEAM)

func process_input(event: InputEvent):
	if event is InputEventMouseMotion and Input.is_action_pressed("g_rotate_about"):
		context.look_x += event.relative.x * context.LOOK_SPEED
		context.look_y += event.relative.y * context.LOOK_SPEED
		var origin_to_cam = (context.get_node("Camera").translation - context.translation)
		origin_to_cam.y = 0.0
		origin_to_cam = origin_to_cam.normalized()
		var to_the_right = origin_to_cam
		to_the_right.x = -origin_to_cam.z
		to_the_right.z = origin_to_cam.x
		context.transform.basis = Basis() # reset rotation
		context.rotate_object_local(Vector3(0, 1, 0), -context.look_x)
		context.rotate_object_local(to_the_right, context.look_y)
	elif event.is_action_pressed("g_zoom_in"):
		context.camera.translation = verify_zoom(calculate_zoom_delta(self.zoom_dir)*-1)
	elif event.is_action_pressed("g_zoom_out"):
		context.camera.translation = verify_zoom(calculate_zoom_delta(self.zoom_dir))

func process_reference_input(_event: InputEvent):
	pass

func out_of():
	pass

func _get_zoom_speed():
	if Input.is_action_pressed("g_zoom_fast"):
		return context.ZOOM_SPEEDS.fast
	elif Input.is_action_pressed("g_zoom_slow"):
		return context.ZOOM_SPEEDS.slow
	else:
		return context.ZOOM_SPEEDS.normal

func verify_zoom(zoom_delta):
	var new_pos = context.camera.translation + zoom_delta
	if new_pos.y <= 1:
		return context.camera.translation
	return new_pos

func calculate_zoom_delta(direction: Vector3) -> Vector3:
	return direction * self.zoom_speed

func _get_zoom_dir() -> Vector3:
	return context.camera.translation.normalized()