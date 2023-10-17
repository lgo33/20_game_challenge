extends CharacterBody2D

var target_velocity: Vector2 = Vector2.ZERO
const speed: int = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	target_velocity = Vector2.ZERO
	
	if Input.is_action_pressed("Player A UP"):
		target_velocity += Vector2.UP * speed
	
	if Input.is_action_pressed("Player A DOWN"):
		target_velocity += Vector2.DOWN * speed

	velocity = lerp(velocity, target_velocity, delta*5)
	move_and_collide(velocity*delta)
