extends Node

const camera_controller_type = preload("res://camera/CameraController.gd")

func into():
	pass
#	Input.set_default_cursor_shape(Input.CURSOR_IBEAM)

func process_input(context: camera_controller_type, event: InputEvent):
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
		context.camera.translation += get_zoom_dir(context)*context.ZOOM_SPEED*-1
	elif event.is_action_pressed("g_zoom_out"):
		context.camera.translation += get_zoom_dir(context)*context.ZOOM_SPEED

func process_reference_input(_context: camera_controller_type, _event: InputEvent):
	pass

func out_of():
	pass

func get_zoom_dir(context: camera_controller_type) -> Vector3:
	return context.camera.translation.normalized()