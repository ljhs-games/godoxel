extends Spatial

export (NodePath) var err_popup_path

#warning-ignore:unused_class_variable
var err_popup: AcceptDialog setget ,get_err_popup

func get_err_popup() -> AcceptDialog:
	return get_node(err_popup_path) as AcceptDialog