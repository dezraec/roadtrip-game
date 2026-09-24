extends Node2D

var van_ragdoll_scn = preload("res://van_ragdoll.tscn")

func _defer(ragdoll):
	get_tree().current_scene.add_child(ragdoll)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "van":
		
		if not is_instance_valid(body):
			return
		
		body.hide()
		
		var ragdoll: RigidBody2D = van_ragdoll_scn.instantiate()
		call_deferred("_defer", ragdoll)
		
		await get_tree().process_frame
		
		ragdoll.global_position = body.global_position + Vector2(0, -50)
		body.process_mode = Node.PROCESS_MODE_DISABLED
		
		var impulse = Vector2.from_angle(-PI/4 + randf() * PI/8) * 100
		
		print(impulse)
		
		ragdoll.apply_impulse(impulse)
		ragdoll.apply_torque_impulse(700*9)
		
		await get_tree().create_timer(1).timeout
		
		get_tree().change_scene_to_file("res://gameover.tscn")
