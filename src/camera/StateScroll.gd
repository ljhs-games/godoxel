extends Node

const camera_controller_type = preload("res://camera/CameraController.gd")

func into():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#	Input.set_default_cursor_shape(Input.CURSOR_DRAG)

func process_input(context: camera_controller_type, event: InputEvent):
	if event.is_action_pressed("g_zoom_in"):
		context.camera.translation += get_zoom_dir(context)*context.ZOOM_SPEED*-1
	elif event.is_action_pressed("g_zoom_out"):
		context.camera.translation += get_zoom_dir(context)*context.ZOOM_SPEED

func process_reference_input(context: camera_controller_type, event: InputEvent):
	if event.is_action_pressed("g_rotate_about"):
		context.cur_state = get_parent().get_node("StateRotateAbout")

func out_of():
	pass

func get_zoom_dir(context: camera_controller_type) -> Vector3:
	return context.camera.translation.normalized()