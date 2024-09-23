class_name Global

static var players: Array = [
	null,
	null
]

static func get_player_color(player_number: int):
	if (player_number == 0): return "red"
	if (player_number == 1): return "blue"
	return "gray"

static var world = 1
static var level = 1
static func update_color():
	RenderingServer.set_default_clear_color(Levels.background_color[world-1])
