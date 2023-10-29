extends CharacterBody2D

signal crashed(collision)

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") or \
		Input.is_action_just_pressed("Player A UP") or \
		Input.is_action_just_pressed("Mouse1"):
		velocity.y = JUMP_VELOCITY
	
	var target_rotation := Vector2(600, velocity.y).angle()
	rotation = lerp(rotation, target_rotation, delta * 10)

	var collision = move_and_collide(velocity * delta)
	if collision:
		print(collision)
		crashed.emit(collision)
