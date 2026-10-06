extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# When the van hits death_zone, the game will switch to the "Gameover" screen
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "van":
		$CollisionShape2D.set_deferred("disabled", true)
		get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
