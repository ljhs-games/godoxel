extends Camera

# Declare member variables here. Examples:
export (NodePath) var color_picker_path

onready var color_picker: ColorPickerButton = get_node(color_picker_path)

func _ready():
	color_picker.connect("color_changed", self, "_on_SetEnvironmentColor_color_changed")
	color_picker.color = environment.background_color


func _on_SetEnvironmentColor_color_changed(color):
	environment.background_color = color