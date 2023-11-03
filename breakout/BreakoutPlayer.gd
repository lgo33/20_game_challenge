extends CharacterBody2D

var target_velocity: Vector2 = Vector2.ZERO
const speed: int = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	target_velocity = Vector2.ZERO
	
	if Input.is_action_pressed("Player A LEFT"):
		target_velocity += Vector2.LEFT * speed
	
	if Input.is_action_pressed("Player A RIGHT"):
		target_velocity += Vector2.RIGHT * speed

	velocity = lerp(velocity, target_velocity, delta*10)
	var collision = move_and_collide(velocity*delta)
#	if collision:
#		print(collision)
