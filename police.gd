extends RigidBody2D

@export var chaseFactor: float = 80
@export var distancePower: float = 1.2
@export var chaseFlyFactor: float = 20
var tick: int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var vanRef: CharacterBody2D = VanLocator.van # This is police's own local reference to the van's location.
	
	var target = vanRef.global_position
	var distance = pow(target.distance_to(global_position), distancePower)
	var dir = global_position.direction_to(target)
	
	var result = dir * distance * chaseFactor * delta
	
	apply_central_force(result)
	
	if tick % 90 == 0 and global_position.y > target.y:
		apply_central_force(Vector2.UP * chaseFlyFactor * delta)
	
	print(result)
