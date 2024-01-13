extends TileMap

var astargrid = AStarGrid2D.new()
const main_layer = 0
const main_source = 0
const path_taken_atlas_coords = Vector2i(2, 0)

const is_solid = "is_solid"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_grid()
	show_path()

func setup_grid():
	astargrid.region = Rect2i(-2, -2, 16, 16)
	astargrid.cell_size = Vector2i(64, 64)
	astargrid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astargrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astargrid.update()
	for cell in get_used_cells(main_layer):
		#prints(cell, is_spot_solid(cell))
		astargrid.set_point_solid(cell, is_spot_solid(cell))

func show_path():
	var path_taken = astargrid.get_id_path(Vector2i(1,1), Vector2i(7, 6))
	for cell in path_taken:
		set_cell(main_layer, cell, main_source, path_taken_atlas_coords)
		await get_tree().create_timer(.2).timeout

func is_spot_solid(spot_to_check: Vector2i) -> bool:
	return get_cell_tile_data(main_layer, spot_to_check).get_custom_data(is_solid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
