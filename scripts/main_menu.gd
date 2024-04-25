extends Node


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	Global.total_collected = 0
	Global.lives = 3
	
func _on_quit_pressed():
	get_tree().quit()
