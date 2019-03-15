extends MeshInstance

const faded_opacity = 0.2
const transition_time = 0.5

export (NodePath) var camera_path

onready var camera_node = get_node(camera_path) as Camera

var under_plane = false setget _set_under_plane

func _process(_delta):
	if camera_node.global_transform.origin.y <= 1:
		self.under_plane = true
	else:
		self.under_plane = false

func _set_under_plane(new_under_plane):
	if new_under_plane != under_plane:
		under_plane = new_under_plane
		if under_plane == true:
			$FadeTween.stop_all()
			$FadeTween.interpolate_property(mesh.surface_get_material(0), "shader_param/opacity", mesh.surface_get_material(0).get_shader_param("opacity"), faded_opacity, transition_time, Tween.TRANS_EXPO, Tween.EASE_OUT)
			$FadeTween.start()
		elif under_plane == false:
			$FadeTween.stop_all()
			$FadeTween.interpolate_property(mesh.surface_get_material(0), "shader_param/opacity", mesh.surface_get_material(0).get_shader_param("opacity"), 1, transition_time, Tween.TRANS_EXPO, Tween.EASE_OUT)
			$FadeTween.start()