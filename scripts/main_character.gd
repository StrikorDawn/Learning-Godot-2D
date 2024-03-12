extends CharacterBody2D

@export var move_speed = 400
@export var jump_height : float = 150
@export var jump_time_to_peak : float = .5
@export var jump_time_to_descent : float = 0.4
@export var coyote_time: float = 0.075
@export var jump_buffer_time: float = 0.15
@export var fall_clamp : float = 100
var jump_available: bool = true
var jump_buffer: bool = false

@onready var jump_buffer_timer = $Jump_Buffer_Timer
@onready var coyote_timer = $Coyote_Timer
@onready var sprite_2d = $Sprite2D
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _physics_process(delta):
	#Animations
	if (velocity.y < 0):
		sprite_2d.animation = "jumping"
	elif (velocity.y > 0):
		sprite_2d.animation = "falling"
	elif (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "idle"
		
	velocity.y += get_gravity() * delta
	velocity.x = get_input_velocity() * move_speed
	
	if Input.is_action_just_pressed("jump"):
		if jump_available:
			jump()
		else:
			jump_buffer = true
			if jump_buffer_timer.is_stopped():
				jump_buffer_timer.start(jump_buffer_time)

	if not is_on_floor():
		if coyote_timer.is_stopped():
			coyote_timer.start(coyote_time)
			
		if (velocity.y < 0 && Input.is_action_just_released("jump")):
			velocity.y = 0
	else:
		jump_available = true
		coyote_timer.stop()
		if jump_buffer:
			jump()
			jump_buffer = false
	
	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
	
func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity
	jump_available = false
	
func on_jump_buffer_timeout():
	jump_buffer = false
	
func coyote_timeout():
	jump_available = false

func get_input_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("left"):
		horizontal -= 1.0
	if Input.is_action_pressed("right"):
		horizontal += 1.0
		
	return horizontal
