@tool
class_name Global

static var default_bg = Color("#fffdeb")
static var default_tint = Color("#d88b07")

static var players: Array = [
	null,
	null
]

static func get_player_color(player_number: int):
	if (player_number == 0): return "red"
	if (player_number == 1): return "blue"
	return "gray"

static var world = 2
static var level = 3
static func update_color():
	RenderingServer.set_default_clear_color(Levels.background_color[world-1])
static func reset_color():
	RenderingServer.set_default_clear_color(default_bg)


static func get_tint_color(world: int):
	var index = world - 1
	if index < 0: return Global.default_tint
	if Levels.tiles_color.size() <= index: return Global.default_tint
	return Levels.tiles_color[index]
