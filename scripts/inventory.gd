extends Node

# Inventory system

signal inventory_changed
signal item_added(item_name, amount)
signal item_removed(item_name, amount)

var items: Dictionary = {}
var max_stack_size: int = 99

func _ready():
	# Initialize with some basic items
	pass

func add_item(item_name: String, amount: int = 1) -> bool:
	if items.has(item_name):
		items[item_name] = min(items[item_name] + amount, max_stack_size)
	else:
		items[item_name] = min(amount, max_stack_size)
	
	emit_signal("item_added", item_name, amount)
	emit_signal("inventory_changed")
	return true

func remove_item(item_name: String, amount: int = 1) -> bool:
	if not items.has(item_name):
		return false
	
	if items[item_name] < amount:
		return false
	
	items[item_name] -= amount
	if items[item_name] <= 0:
		items.erase(item_name)
	
	emit_signal("item_removed", item_name, amount)
	emit_signal("inventory_changed")
	return true

func has_item(item_name: String, amount: int = 1) -> bool:
	return items.has(item_name) and items[item_name] >= amount

func get_item_count(item_name: String) -> int:
	if items.has(item_name):
		return items[item_name]
	return 0

func get_all_items() -> Dictionary:
	return items.duplicate()

func clear():
	items.clear()
	emit_signal("inventory_changed")
