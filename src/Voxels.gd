extends MeshInstance

const default_color = Color(0.8, 0.8, 0.8)
export (Material) var material = SpatialMaterial.new()

class Quad:
	var vertices: PoolVector3Array

	func _init(vertices: Array):
		self.vertices = PoolVector3Array(vertices)

	func add_vertices(st: SurfaceTool):
		assert( vertices.size() == 4 )
		st.add_vertex(vertices[0])
		st.add_vertex(vertices[1])
		st.add_vertex(vertices[2])
		st.add_vertex(vertices[3])
		st.add_vertex(vertices[0])
		st.add_vertex(vertices[2])

class Voxel:
	var color: Color
	var position: Vector3
	
	func _init(color = default_color, position = Vector3()):
		self.color = color
		self.position = position
	
	func get_vertices() -> PoolVector3Array:
		var to_return = []
		to_return.append(Vector3(self.position.x, self.position.y, self.position.z))
		to_return.append(Vector3(self.position.x + 1, self.position.y, self.position.z))
		to_return.append(Vector3(self.position.x + 1, self.position.y, self.position.z - 1))
		to_return.append(Vector3(self.position.x, self.position.y, self.position.z - 1))
		
		to_return.append(Vector3(self.position.x, self.position.y + 1, self.position.z))
		to_return.append(Vector3(self.position.x + 1, self.position.y + 1, self.position.z))
		to_return.append(Vector3(self.position.x + 1, self.position.y + 1, self.position.z - 1))
		to_return.append(Vector3(self.position.x, self.position.y + 1, self.position.z - 1))
		return PoolVector3Array(to_return)

	func add_vertices(st: SurfaceTool):
		var v = self.get_vertices()
		Quad.new([v[0], v[1], v[2], v[3]]).add_vertices(st)
		Quad.new([v[5], v[6], v[2], v[1]]).add_vertices(st)
		Quad.new([v[0], v[4], v[5], v[1]]).add_vertices(st)
		Quad.new([v[3], v[7], v[4], v[0]]).add_vertices(st)
		Quad.new([v[6], v[7], v[3], v[2]]).add_vertices(st)
		Quad.new([v[7], v[6], v[5], v[4]]).add_vertices(st)

var voxels = [Voxel.new(), Voxel.new(Color(1,0,0), Vector3(1,0,0)), Voxel.new(Color(0,1,0), Vector3(1,1,0))]

func _ready():
	mesh = build_mesh(voxels, material)

static func build_mesh(voxels, material) -> ArrayMesh:
	var st = SurfaceTool.new()

	material.vertex_color_use_as_albedo = true
	
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	st.set_material(material)
	
	for vox in voxels:
		st.add_color(vox.color)
		vox.add_vertices(st)
	
	st.generate_normals()
	st.index()
	return st.commit()