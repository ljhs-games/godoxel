extends Spatial

const LOOK_SPEED = 0.005
const ZOOM_SPEED = 2

onready var cur_state = null setget _set_state
onready var camera = $Camera

var look_x = 0.0
var look_y = 0.0

func _ready():
	self.cur_state = $StateNormal
	set_process_input(true)
	set_physics_process(true)

func _input(event):
	cur_state.process_input(self, event)

func _set_state(new_state):
	if cur_state != null:
		cur_state.out_of()
	cur_state = new_state
	new_state.into()

func _on_ReferenceRect_gui_input(event):
	cur_state.process_reference_input(self, event)