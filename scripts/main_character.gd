extends CharacterBody2D
@onready var sprite = $Sprite2D
@onready var jump_buffer_timer = $Jump_Buffer_Timer
@onready var coyote_timer = $Coyote_Timer
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
@onready var hitbox = $Hitbox
@onready var feet = $Feet

@export var move_speed = 275
@export var jump_height : float = 100
@export var jump_time_to_peak : float = .5
@export var jump_time_to_descent : float = 0.4
@export var coyote_time: float = 0.075
@export var jump_buffer_time: float = 0.15
@export var fall_clamp : float = 100
var is_dying = false
var is_jumping = false
var jump_available: bool = true
var jump_buffer: bool = false

func _ready():
	add_to_group("Player")
	
func _physics_process(delta):
	if is_dying:
		return
	
	# Add the gravity
	velocity.y += get_gravity() * delta
	if not is_on_floor():
		if coyote_timer.is_stopped():
			coyote_timer.start(coyote_time)
			
		if (velocity.y < 0 && Input.is_action_just_released("jump")):
			velocity.y = 0
	else:
		is_jumping = false
		jump_available = true
		coyote_timer.stop()
		if jump_buffer:
			jump()
			jump_buffer = false

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if jump_available:
			jump()
		else:
			jump_buffer = true
			if jump_buffer_timer.is_stopped():
				jump_buffer_timer.start(jump_buffer_time)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	update_animation(direction)
	move_and_slide()

func update_animation(direction):
	if is_dying:
		return
	if is_jumping:
		sprite.play("jumping")
	elif direction != 0:
		sprite.flip_h = direction < 0
		sprite.play("running")
	else:
		sprite.play("idle")
		
func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func jump():
	velocity.y = jump_velocity
	jump_available = false
	is_jumping = true
	
func on_jump_buffer_timeout():
	jump_buffer = false
	
func coyote_timeout():
	jump_available = false

func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy") and body.is_alive:
		die()
		
func die():
	if is_dying:
		return
	is_dying = true
	sprite.play("death")
	await death_movement()
	Global.lives -= 1
	if (Global.total_collected - 10) < 0:
		Global.total_collected = 0
	else:
		Global.total_collected -= 10
	if 	Global.lives > 0:
		get_tree().reload_current_scene()
	else:
		Global.lives = 3
		Global.total_collected = 0
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func death_movement():
	var start_position = position
	var up_position = start_position + Vector2(0, -75)
	var fall_postion = start_position + Vector2(0, 150)
	while position.y > up_position.y:
		position.y -= 4
		await get_tree().create_timer(0.01).timeout
	
	while position.y < fall_postion.y:
		position.y += 4
		await get_tree().create_timer(0.01).timeout
