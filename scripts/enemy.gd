extends CharacterBody2D

const SPEED = 25.0
var is_alive = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $AnimatedSprite2D

func _ready():
	add_to_group("Enemy")

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	
	# Set the horizontal velocity to a constant negative value
	velocity.x = -SPEED

	update_animation()
	move_and_slide()

func update_animation():
	sprite.play("walking")


func _on_hitbox_body_entered(body):
	if body.is_in_group("Player") and not body.is_dying:
		is_alive = false
		queue_free()
