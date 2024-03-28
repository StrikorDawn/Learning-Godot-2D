extends Node2D

@export var target_level: PackedScene
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_packed(target_level)
