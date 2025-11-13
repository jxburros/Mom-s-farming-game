extends Node2D

# Main game controller

@onready var player = $Player
@onready var farm = $Farm
@onready var inventory = $Inventory
@ontml:parameter name="crafting = $Crafting
@onready var save_load = $SaveLoad
@onready var ui = $UI
@onready var camera = $Camera2D

var farm_plots: Array = []

func _ready():
	# Setup scripts for singleton-like nodes
	if inventory:
		inventory.set_script(load("res://scripts/inventory.gd"))
	if crafting:
		crafting.set_script(load("res://scripts/crafting.gd"))
	if save_load:
		save_load.set_script(load("res://scripts/save_load.gd"))
	if ui:
		ui.set_script(load("res://scripts/ui_manager.gd"))
	
	# Setup player
	if player:
		player.set_script(load("res://scripts/player.gd"))
	
	# Setup farm plots
	setup_farm_plots()
	
	# Connect day changed signal
	connect("day_changed", Callable(self, "_on_day_changed"))
	
	# Setup UI
	if ui and inventory and crafting:
		ui.setup(self, inventory, crafting)
	
	# Connect UI buttons
	connect_ui_signals()
	
	# Make camera follow player
	if camera and player:
		camera.position = player.position
	
	print("Game started successfully!")

func _process(_delta):
	# Update camera to follow player
	if camera and player:
		camera.position = player.position

func setup_farm_plots():
	if not farm:
		return
	
	# Get all farm plot nodes
	for child in farm.get_children():
		if "FarmPlot" in child.name:
			child.set_script(load("res://scripts/farm_plot.gd"))
			farm_plots.append(child)
			# Connect interaction
			if child.has_node("Area2D"):
				var area = child.get_node("Area2D")
				area.connect("input_event", Callable(self, "_on_plot_clicked").bind(child))

func connect_ui_signals():
	if not ui:
		return
	
	# Connect inventory button
	if ui.has_node("HUD/InventoryButton"):
		var btn = ui.get_node("HUD/InventoryButton")
		btn.connect("pressed", Callable(ui, "toggle_inventory"))
	
	# Connect crafting button
	if ui.has_node("HUD/CraftingButton"):
		var btn = ui.get_node("HUD/CraftingButton")
		btn.connect("pressed", Callable(ui, "toggle_crafting"))
	
	# Connect save button
	if ui.has_node("HUD/SaveButton"):
		var btn = ui.get_node("HUD/SaveButton")
		btn.connect("pressed", Callable(self, "_on_save_button_pressed"))
	
	# Connect load button
	if ui.has_node("HUD/LoadButton"):
		var btn = ui.get_node("HUD/LoadButton")
		btn.connect("pressed", Callable(self, "_on_load_button_pressed"))
	
	# Connect inventory panel close button
	if ui.has_node("InventoryPanel/CloseButton"):
		var btn = ui.get_node("InventoryPanel/CloseButton")
		btn.connect("pressed", Callable(ui, "toggle_inventory"))
	
	# Connect crafting panel close button
	if ui.has_node("CraftingPanel/CloseButton"):
		var btn = ui.get_node("CraftingPanel/CloseButton")
		btn.connect("pressed", Callable(ui, "toggle_crafting"))
	
	# Connect craft button
	if ui.has_node("CraftingPanel/CraftButton"):
		var btn = ui.get_node("CraftingPanel/CraftButton")
		btn.connect("pressed", Callable(self, "_on_craft_button_pressed"))
	
	# Connect recipe list selection
	if ui.has_node("CraftingPanel/RecipeList"):
		var list = ui.get_node("CraftingPanel/RecipeList")
		list.connect("item_selected", Callable(self, "_on_recipe_selected"))

func _on_plot_clicked(viewport, event, shape_idx, plot):
	if event is InputEventMouseButton and event.pressed:
		interact_with_plot(plot)

func interact_with_plot(plot):
	if not plot or not plot.has_method("get_state"):
		return
	
	var state = plot.get_state()
	
	# Simple interaction logic
	if state == 0:  # EMPTY
		plot.till()
	elif state == 1:  # TILLED
		# Plant wheat by default (in full game, would show crop selection)
		plot.plant(1)  # WHEAT
	elif state == 2:  # PLANTED
		plot.water()
	elif state == 4:  # READY_TO_HARVEST
		var result = plot.harvest()
		if result.has("crop") and result.has("amount"):
			inventory.add_item(result["crop"], result["amount"])

func _on_day_changed(day):
	# Update all farm plots
	for plot in farm_plots:
		if plot.has_method("update_day"):
			plot.update_day(day)

func _on_save_button_pressed():
	if save_load and player:
		var state = save_load.create_game_state(self, inventory, player.global_position, farm_plots)
		save_load.save_game(state)

func _on_load_button_pressed():
	if save_load:
		var state = save_load.load_game()
		if state.size() > 0:
			save_load.restore_game_state(state, self, inventory, player, farm_plots)
			if ui:
				ui.update_all_displays()

var selected_recipe_index: int = -1

func _on_recipe_selected(index):
	selected_recipe_index = index

func _on_craft_button_pressed():
	if selected_recipe_index < 0 or not crafting or not ui:
		return
	
	if not ui.has_node("CraftingPanel/RecipeList"):
		return
	
	var recipe_list = ui.get_node("CraftingPanel/RecipeList")
	if selected_recipe_index >= recipe_list.item_count:
		return
	
	var recipe_name = recipe_list.get_item_text(selected_recipe_index)
	# Remove the checkmark suffix
	recipe_name = recipe_name.replace(" ✓", "").replace(" ✗", "")
	
	if crafting.craft_item(recipe_name, inventory):
		print("Crafted: ", recipe_name)
		ui.update_crafting_display()
		ui.update_inventory_display()
	else:
		print("Cannot craft: ", recipe_name)
