extends Node

# Save/Load system

const SAVE_FILE_PATH = "user://savegame.json"

func save_game(game_state: Dictionary) -> bool:
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file == null:
		print("Error: Could not open save file for writing")
		return false
	
	var json_string = JSON.stringify(game_state)
	file.store_string(json_string)
	file.close()
	
	print("Game saved successfully")
	return true

func load_game() -> Dictionary:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		print("No save file found")
		return {}
	
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if file == null:
		print("Error: Could not open save file for reading")
		return {}
	
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	
	if parse_result != OK:
		print("Error parsing save file")
		return {}
	
	print("Game loaded successfully")
	return json.get_data()

func has_save_file() -> bool:
	return FileAccess.file_exists(SAVE_FILE_PATH)

func delete_save() -> bool:
	if has_save_file():
		DirAccess.remove_absolute(SAVE_FILE_PATH)
		return true
	return false

func create_game_state(game_manager: Node, inventory: Node, player_position: Vector2, farm_plots: Array) -> Dictionary:
	var state = {
		"version": "1.0",
		"timestamp": Time.get_unix_time_from_system(),
		"player": {
			"position": {"x": player_position.x, "y": player_position.y}
		},
		"time": {
			"hour": game_manager.current_hour,
			"minute": game_manager.current_minute,
			"day": game_manager.current_day
		},
		"weather": game_manager.current_weather,
		"inventory": inventory.get_all_items(),
		"farm_plots": []
	}
	
	# Save farm plot states
	for plot in farm_plots:
		if plot.has_method("get_state"):
			state["farm_plots"].append({
				"state": plot.get_state(),
				"crop_type": plot.get_crop_type(),
				"growth_progress": plot.growth_progress
			})
	
	return state

func restore_game_state(state: Dictionary, game_manager: Node, inventory: Node, player: Node, farm_plots: Array):
	# Restore player position
	if state.has("player") and state["player"].has("position"):
		var pos = state["player"]["position"]
		player.global_position = Vector2(pos["x"], pos["y"])
	
	# Restore time
	if state.has("time"):
		game_manager.current_hour = state["time"]["hour"]
		game_manager.current_minute = state["time"]["minute"]
		game_manager.current_day = state["time"]["day"]
	
	# Restore weather
	if state.has("weather"):
		game_manager.current_weather = state["weather"]
	
	# Restore inventory
	if state.has("inventory"):
		inventory.clear()
		for item_name in state["inventory"]:
			inventory.add_item(item_name, state["inventory"][item_name])
	
	# Restore farm plots
	if state.has("farm_plots"):
		for i in range(min(state["farm_plots"].size(), farm_plots.size())):
			var plot_state = state["farm_plots"][i]
			var plot = farm_plots[i]
			if plot.has_method("get_state"):
				plot.state = plot_state["state"]
				plot.crop_type = plot_state["crop_type"]
				plot.growth_progress = plot_state.get("growth_progress", 0.0)
				plot.update_visual()
