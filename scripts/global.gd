@tool
class_name Global

static var is_mobil = false

static var default_bg = Color("#fffdeb")
static var default_tint = Color("#d88b07")

static var players: Array = [
	null,
	null
]

static var world = 3
static var level = 4

static var last_world = 3

static func update_color():
	RenderingServer.set_default_clear_color(Levels.background_color[world-1])
static func reset_color():
	RenderingServer.set_default_clear_color(default_bg)

# TODO: HACER ESTO
static func save_info(key: String, value: String):
	pass
static func get_info(key: String):
	pass


static func get_tint_color(world: int):
	var index = world - 1
	if index < 0: return Global.default_tint
	if Levels.tiles_color.size() <= index: return Global.default_tint
	return Levels.tiles_color[index]
