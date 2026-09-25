extends RigidBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
	var vanRef = VanLocator.van # This is police's own local reference to the van's location.
	
	# TO-DO:
	# Find direction and magnitude from polic to van
	# Use that to apply_force()
	# Make sure to multuiply your result with delta
	
	# First step - get reference to van
