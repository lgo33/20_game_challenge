extends CharacterBody2D

var target_velocity: Vector2 = Vector2.ZERO
const speed: int = 400

@export var ai_player:bool = false
@onready var ball = $"../Ball"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	target_velocity = Vector2.ZERO
	
	if ai_player:
		target_velocity = get_ai_control()
	else:	
		if Input.is_action_pressed("Player B UP"):
			target_velocity += Vector2.UP * speed
		
		if Input.is_action_pressed("Player B DOWN"):
			target_velocity += Vector2.DOWN * speed

	velocity = lerp(velocity, target_velocity, delta*10)
	move_and_collide(velocity*delta)

func get_ai_control():
	if (ball.position.y - position.y) > 10:
		return Vector2.DOWN * speed
	elif (position.y - ball.position.y) > 10:
		return Vector2.UP * speed
	return Vector2.ZERO
