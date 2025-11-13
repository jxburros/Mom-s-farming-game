extends Node2D

# Farming plot that can be tilled, planted, watered, and harvested

enum PlotState { EMPTY, TILLED, PLANTED, WATERED, READY_TO_HARVEST }
enum CropType { NONE, WHEAT, CARROT, TOMATO }

var state: PlotState = PlotState.EMPTY
var crop_type: CropType = CropType.NONE
var growth_progress: float = 0.0
var days_to_grow: int = 0
var current_day: int = 0

# Crop growth times (in days)
var crop_data = {
	CropType.WHEAT: {"days": 3, "yield": 2, "name": "Wheat"},
	CropType.CARROT: {"days": 4, "yield": 3, "name": "Carrot"},
	CropType.TOMATO: {"days": 5, "yield": 4, "name": "Tomato"}
}

func _ready():
	update_visual()

func till():
	if state == PlotState.EMPTY:
		state = PlotState.TILLED
		update_visual()
		return true
	return false

func plant(crop: CropType):
	if state == PlotState.TILLED and crop != CropType.NONE:
		state = PlotState.PLANTED
		crop_type = crop
		growth_progress = 0.0
		days_to_grow = crop_data[crop]["days"]
		update_visual()
		return true
	return false

func water():
	if state == PlotState.PLANTED:
		state = PlotState.WATERED
		update_visual()
		return true
	return false

func harvest() -> Dictionary:
	if state == PlotState.READY_TO_HARVEST:
		var result = {
			"crop": crop_data[crop_type]["name"],
			"amount": crop_data[crop_type]["yield"]
		}
		state = PlotState.EMPTY
		crop_type = CropType.NONE
		growth_progress = 0.0
		update_visual()
		return result
	return {}

func update_day(day: int):
	current_day = day
	if state == PlotState.WATERED:
		growth_progress += 1.0
		if growth_progress >= days_to_grow:
			state = PlotState.READY_TO_HARVEST
		else:
			state = PlotState.PLANTED
		update_visual()

func update_visual():
	# Update the sprite based on state
	if has_node("Sprite2D"):
		var sprite = $Sprite2D
		match state:
			PlotState.EMPTY:
				sprite.modulate = Color(0.6, 0.4, 0.2)  # Brown
			PlotState.TILLED:
				sprite.modulate = Color(0.4, 0.3, 0.2)  # Dark brown
			PlotState.PLANTED:
				sprite.modulate = Color(0.3, 0.5, 0.2)  # Green
			PlotState.WATERED:
				sprite.modulate = Color(0.2, 0.4, 0.6)  # Blue-green
			PlotState.READY_TO_HARVEST:
				sprite.modulate = Color(0.8, 0.7, 0.2)  # Golden

func get_state() -> PlotState:
	return state

func get_crop_type() -> CropType:
	return crop_type
