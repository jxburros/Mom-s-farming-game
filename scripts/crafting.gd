extends Node

# Crafting system

signal item_crafted(item_name)

var recipes: Dictionary = {}

func _ready():
	setup_recipes()

func setup_recipes():
	# Define crafting recipes
	# Format: result_item: {ingredients: {item: count}, result_count: X}
	recipes = {
		"Bread": {
			"ingredients": {"Wheat": 3},
			"result_count": 1
		},
		"Salad": {
			"ingredients": {"Carrot": 2, "Tomato": 2},
			"result_count": 1
		},
		"Vegetable Soup": {
			"ingredients": {"Carrot": 1, "Tomato": 1, "Wheat": 1},
			"result_count": 1
		},
		"Tomato Sauce": {
			"ingredients": {"Tomato": 5},
			"result_count": 2
		},
		"Carrot Cake": {
			"ingredients": {"Carrot": 4, "Wheat": 2},
			"result_count": 1
		}
	}

func can_craft(item_name: String, inventory: Node) -> bool:
	if not recipes.has(item_name):
		return false
	
	var recipe = recipes[item_name]
	for ingredient in recipe["ingredients"]:
		var required_amount = recipe["ingredients"][ingredient]
		if not inventory.has_item(ingredient, required_amount):
			return false
	
	return true

func craft_item(item_name: String, inventory: Node) -> bool:
	if not can_craft(item_name, inventory):
		return false
	
	var recipe = recipes[item_name]
	
	# Remove ingredients
	for ingredient in recipe["ingredients"]:
		var required_amount = recipe["ingredients"][ingredient]
		inventory.remove_item(ingredient, required_amount)
	
	# Add crafted item
	inventory.add_item(item_name, recipe["result_count"])
	emit_signal("item_crafted", item_name)
	
	return true

func get_all_recipes() -> Dictionary:
	return recipes.duplicate()

func get_recipe(item_name: String) -> Dictionary:
	if recipes.has(item_name):
		return recipes[item_name].duplicate()
	return {}
