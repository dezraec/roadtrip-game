extends Control


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://van_test_map.tscn")
