extends Node

# NPC with relationship system

signal relationship_changed(npc_name, new_level)

var npc_name: String = "Villager"
var relationship_level: int = 0  # 0-100
var dialogue_options: Array = []
var daily_interaction_done: bool = false

func _ready():
	setup_dialogue()

func setup_dialogue():
	dialogue_options = [
		"Hello there! How are you today?",
		"The weather is nice, isn't it?",
		"Have you been farming long?",
		"I love what you've done with your farm!",
		"Thanks for talking with me!"
	]

func interact() -> String:
	if daily_interaction_done:
		return "We've already talked today. Come back tomorrow!"
	
	daily_interaction_done = false
	var dialogue = dialogue_options[randi() % dialogue_options.size()]
	increase_relationship(5)
	return dialogue

func give_gift(item_name: String) -> String:
	var loved_items = ["Tomato", "Wheat"]
	var liked_items = ["Carrot"]
	
	if item_name in loved_items:
		increase_relationship(20)
		return "Oh wow! I love this! Thank you so much!"
	elif item_name in liked_items:
		increase_relationship(10)
		return "Thank you! I really like this."
	else:
		increase_relationship(5)
		return "Thanks for the gift."

func increase_relationship(amount: int):
	var old_level = relationship_level
	relationship_level = min(relationship_level + amount, 100)
	
	if old_level != relationship_level:
		emit_signal("relationship_changed", npc_name, relationship_level)

func decrease_relationship(amount: int):
	var old_level = relationship_level
	relationship_level = max(relationship_level - amount, 0)
	
	if old_level != relationship_level:
		emit_signal("relationship_changed", npc_name, relationship_level)

func reset_daily():
	daily_interaction_done = false

func get_relationship_level() -> int:
	return relationship_level

func get_relationship_tier() -> String:
	if relationship_level >= 80:
		return "Best Friends"
	elif relationship_level >= 60:
		return "Good Friends"
	elif relationship_level >= 40:
		return "Friends"
	elif relationship_level >= 20:
		return "Acquaintances"
	else:
		return "Strangers"
