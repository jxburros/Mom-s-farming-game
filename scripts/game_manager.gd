extends Node2D

# Game manager - handles day/night cycle, weather, and global state

signal time_changed(hour, minute)
signal day_changed(day)
signal weather_changed(weather_type)

enum Weather { SUNNY, RAINY, CLOUDY }

@export var time_scale: float = 60.0  # Game minutes per real second
@export var day_length_hours: int = 24

var current_hour: int = 6
var current_minute: int = 0
var current_day: int = 1
var current_weather: Weather = Weather.SUNNY

var time_accumulator: float = 0.0

func _ready():
	randomize()
	change_weather()

func _process(delta):
	# Update time
	time_accumulator += delta * time_scale
	
	while time_accumulator >= 60.0:
		time_accumulator -= 60.0
		current_minute += 1
		
		if current_minute >= 60:
			current_minute = 0
			current_hour += 1
			emit_signal("time_changed", current_hour, current_minute)
			
			if current_hour >= day_length_hours:
				current_hour = 0
				current_day += 1
				emit_signal("day_changed", current_day)
				# Chance to change weather each new day
				if randf() < 0.3:
					change_weather()
	
	# Update day/night lighting
	update_lighting()

func update_lighting():
	var time_of_day = current_hour + (current_minute / 60.0)
	var darkness = 0.0
	
	# Night time (20:00 - 6:00)
	if time_of_day >= 20 or time_of_day < 6:
		if time_of_day >= 20:
			darkness = min((time_of_day - 20) / 2.0, 1.0)
		else:
			darkness = max(1.0 - (time_of_day / 2.0), 0.0)
	
	# Apply darkness to the scene (would use CanvasModulate in actual scene)
	if has_node("CanvasModulate"):
		var light_color = Color(1.0 - darkness * 0.6, 1.0 - darkness * 0.6, 1.0 - darkness * 0.4)
		$CanvasModulate.color = light_color

func change_weather():
	var rand = randf()
	if rand < 0.5:
		current_weather = Weather.SUNNY
	elif rand < 0.8:
		current_weather = Weather.CLOUDY
	else:
		current_weather = Weather.RAINY
	
	emit_signal("weather_changed", current_weather)

func get_time_string() -> String:
	return "%02d:%02d" % [current_hour, current_minute]

func get_day() -> int:
	return current_day

func get_weather() -> Weather:
	return current_weather

func is_night() -> bool:
	return current_hour >= 20 or current_hour < 6

func is_raining() -> bool:
	return current_weather == Weather.RAINY
