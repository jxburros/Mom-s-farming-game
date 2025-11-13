extends CharacterBody2D

# Player movement script with touch controls

@export var speed: float = 200.0

var touch_position: Vector2 = Vector2.ZERO
var is_touching: bool = false

func _ready():
	pass

func _input(event):
	# Handle touch input for mobile
	if event is InputEventScreenTouch:
		if event.pressed:
			is_touching = true
			touch_position = event.position
		else:
			is_touching = false
	elif event is InputEventScreenDrag:
		touch_position = event.position

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	# Handle keyboard input (for testing)
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	# Handle touch input
	if is_touching:
		var touch_direction = (touch_position - get_viewport().get_screen_transform() * global_position).normalized()
		if touch_direction.length() > 0.1:
			direction = touch_direction
	
	# Normalize diagonal movement
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Apply movement
	velocity = direction * speed
	move_and_slide()
	
	# Update animation based on direction
	if direction.length() > 0:
		$AnimatedSprite2D.play("walk")
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif direction.x > 0:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
