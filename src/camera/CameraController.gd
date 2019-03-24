extends Spatial

const LOOK_SPEED = 0.005
const PAN_SPEED = 0.03
const ZOOM_SPEEDS = {"slow": 0.5, "normal": 1, "fast": 5}

onready var cur_state = null setget _set_state
#warning-ignore:unused_class_variable
onready var camera = $Camera

#warning-ignore:unused_class_variable
var look_x = 0.0
#warning-ignore:unused_class_variable
var look_y = 0.0

func _ready():
	self.cur_state = $StateNormal
	set_process_input(true)
	set_physics_process(true)

func _input(event):
	cur_state.process_input(event)

func _set_state(new_state):
	if cur_state != null:
		cur_state.out_of()
	cur_state = new_state
	new_state.into()

func _on_ReferenceRect_gui_input(event):
	cur_state.process_reference_input(event)