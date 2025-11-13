extends CanvasLayer

# UI Manager for the game

@onready var inventory_panel = $InventoryPanel
@onready var crafting_panel = $CraftingPanel
@onready var time_label = $HUD/TimeLabel
@onready var day_label = $HUD/DayLabel
@onready var weather_label = $HUD/WeatherLabel
@onready var inventory_button = $HUD/InventoryButton
@ontml:parameter name="crafting_button = $HUD/CraftingButton
@onready var joystick = $TouchControls/Joystick

var game_manager: Node
var inventory: Node
var crafting: Node

func _ready():
	# Hide panels initially
	if inventory_panel:
		inventory_panel.visible = false
	if crafting_panel:
		crafting_panel.visible = false

func setup(gm: Node, inv: Node, craft: Node):
	game_manager = gm
	inventory = inv
	crafting = craft
	
	# Connect signals
	if game_manager:
		game_manager.connect("time_changed", Callable(self, "_on_time_changed"))
		game_manager.connect("day_changed", Callable(self, "_on_day_changed"))
		game_manager.connect("weather_changed", Callable(self, "_on_weather_changed"))
	
	if inventory:
		inventory.connect("inventory_changed", Callable(self, "_on_inventory_changed"))
	
	update_all_displays()

func _on_time_changed(hour: int, minute: int):
	if time_label:
		time_label.text = "Time: %02d:%02d" % [hour, minute]

func _on_day_changed(day: int):
	if day_label:
		day_label.text = "Day: %d" % day

func _on_weather_changed(weather_type):
	if weather_label:
		var weather_names = ["Sunny", "Rainy", "Cloudy"]
		weather_label.text = "Weather: " + weather_names[weather_type]

func _on_inventory_changed():
	update_inventory_display()

func update_all_displays():
	if game_manager:
		_on_time_changed(game_manager.current_hour, game_manager.current_minute)
		_on_day_changed(game_manager.current_day)
		_on_weather_changed(game_manager.current_weather)
	update_inventory_display()

func update_inventory_display():
	if not inventory_panel or not inventory_panel.has_node("ItemList"):
		return
	
	var item_list = inventory_panel.get_node("ItemList")
	item_list.clear()
	
	if inventory:
		var items = inventory.get_all_items()
		for item_name in items:
			item_list.add_item("%s x%d" % [item_name, items[item_name]])

func toggle_inventory():
	if inventory_panel:
		inventory_panel.visible = not inventory_panel.visible
		if inventory_panel.visible:
			update_inventory_display()
		if crafting_panel:
			crafting_panel.visible = false

func toggle_crafting():
	if crafting_panel:
		crafting_panel.visible = not crafting_panel.visible
		if crafting_panel.visible:
			update_crafting_display()
		if inventory_panel:
			inventory_panel.visible = false

func update_crafting_display():
	if not crafting_panel or not crafting_panel.has_node("RecipeList") or not crafting:
		return
	
	var recipe_list = crafting_panel.get_node("RecipeList")
	recipe_list.clear()
	
	var recipes = crafting.get_all_recipes()
	for recipe_name in recipes:
		var can_craft = crafting.can_craft(recipe_name, inventory)
		var suffix = " ✓" if can_craft else " ✗"
		recipe_list.add_item(recipe_name + suffix)

func _on_inventory_button_pressed():
	toggle_inventory()

func _on_crafting_button_pressed():
	toggle_crafting()
