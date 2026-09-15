extends CharacterBody2D

@export var accelaration: float = 10
@export var neutral_braking: float = 5
@export var jump_velocity = -450.0

const MAX_SPEED = 700.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("MoveLeft", "MoveRight")
	
	if direction:
		
		velocity.x += direction * accelaration
		
	else:
		velocity.x = move_toward(velocity.x, 0, neutral_braking)

	

	move_and_slide()
