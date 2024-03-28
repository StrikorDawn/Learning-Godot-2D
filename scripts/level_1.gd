extends Node2D

func _on_pit_body_entered(body):
	if body.is_in_group("Player"):
		body.die()
	if body.is_in_group("Enemy"):
		body.queue_free()
