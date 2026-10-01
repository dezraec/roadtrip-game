extends CharacterBody2D

@export var accelaration: float = 15
@export var neutral_braking: float = 5
@export var braking: float = 30
@export var jump_velocity = -450.0
var deathZone: float = 550.0 


const MAX_SPEED = 500.0
const PUSH_FORCE = 50

func _ready() -> void: # Start
	VanLocator.van
	
	# Handle falling off the map
	#if global_position.y >= deathZone:
		#get_tree().change_scene_to_file("res://gameover.tscn")
		
		#Use a collisioon box as the Death Zone
	VanLocator.van = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : float = Input.get_axis("MoveLeft", "MoveRight")
	
	if direction:
		
		velocity.x += direction * accelaration
		
		if sign(direction) + sign(velocity.x) == 0:
			velocity.x = move_toward(velocity.x, 0, braking)
		
	else:
		velocity.x = move_toward(velocity.x, 0, neutral_braking)
	

	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	if direction != 0:
		$Sprite2D.flip_h = velocity.x < 0

	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	get_tree().change_scene_to_file("res://gameover.tscn")
