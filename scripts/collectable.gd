extends Area2D
@onready var collectable = $Collectable

var is_collected = false

func _ready():
	collectable.play("banana")

func _on_body_entered(body):
	if body.is_in_group("Player") and not is_collected:
		is_collected = true
		$AudioStreamPlayer2D.play()
		collectable.play("collected")
		Global.total_collected += 1
		await get_tree().create_timer(0.25).timeout
		hide()
