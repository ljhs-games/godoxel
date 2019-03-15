extends Node

const camera_controller_type = preload("res://camera/CameraController.gd")

func into():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func process_input(_context: camera_controller_type, _event: InputEvent):
	pass

func process_reference_input(context: camera_controller_type, event: InputEvent):
	if event.is_action_pressed("g_rotate_about"):
		context.cur_state = get_parent().get_node("StateRotateAbout")

func out_of():
	pass