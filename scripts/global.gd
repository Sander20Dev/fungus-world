@tool
class_name Global

static var is_mobil = false

static var default_bg = Color("#fffdeb")
static var default_tint = Color("#d88b07")

static var players: Array = [
	null,
	null
]

static var world = 4
static var level = 4

static var last_world = 4

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

static func get_bg_color(world: int):
	var index = world - 1
	if index < 0: return Global.default_bg
	if Levels.tiles_color.size() <= index: return Global.default_bg
	return Levels.background_color[index]

#region ITEMS

enum ITEMS_NAME {
	KEY,
}

static var item_textures = {
	ITEMS_NAME.KEY: preload("res://assets/sprites/utilities/key.png")
}

static func get_item_texture(item):
	if item == null: return null
	return item_textures[item]

#endregion
