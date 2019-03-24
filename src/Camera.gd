extends Camera

# Declare member variables here. Examples:
export (NodePath) var color_picker_path

onready var color_picker: ColorPickerButton = get_node(color_picker_path)

var default_background_color: Color
var original_color: Color # stores color before closing color popup

func _ready():
	var err = color_picker.connect("color_changed", self, "_on_SetEnvironmentColor_color_changed")
	if err != OK:
		get_node("/root/Main").err_popup.dialog_text = "Error making scene color visible"
		get_node("/root/Main").err_popup.popup()
	err = color_picker.connect("popup_closed", self, "_on_SetEnvironmentColor_popup_closed")
	if err != OK:
		get_node("/root/Main").err_popup.dialog_text = "Error adding color change to undo history"
		get_node("/root/Main").err_popup.popup()
	color_picker.color = environment.background_color
	default_background_color = environment.background_color
	original_color = color_picker.color


func _on_SetEnvironmentColor_color_changed(color: Color):
	environment.background_color = color
#	var undo_redo: UndoRedo = history.undo_redo
#	undo_redo.create_action("Change Scene Color")
#	undo_redo.add_do_property(environment, "background_color", color)
#	undo_redo.add_do_property(color_picker, "color", color)
#	undo_redo.add_undo_property(environment, "background_color", environment.background_color)
#	undo_redo.add_undo_property(color_picker, "color", environment.background_color)
#	undo_redo.commit_action()

func _on_SetEnvironmentColor_popup_closed():
	var undo_redo: UndoRedo = history.undo_redo
	undo_redo.create_action("Change Scene Color")
	undo_redo.add_do_property(environment, "background_color", color_picker.color)
	undo_redo.add_do_property(color_picker, "color", color_picker.color)
	undo_redo.add_undo_property(environment, "background_color", original_color)
	undo_redo.add_undo_property(color_picker, "color", original_color)
	undo_redo.commit_action()
	original_color = color_picker.color

func _on_ResetButton_pressed():
	var undo_redo: UndoRedo = history.undo_redo
	undo_redo.create_action("Reset Scene Color")
	undo_redo.add_do_property(environment, "background_color", default_background_color)
	undo_redo.add_do_property(color_picker, "color", default_background_color)
	undo_redo.add_undo_property(environment, "background_color", environment.background_color)
	undo_redo.add_undo_property(color_picker, "color", environment.background_color)
	undo_redo.commit_action()