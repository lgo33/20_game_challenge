extends CharacterBody2D
class_name BOPlayer

var target_velocity: Vector2 = Vector2.ZERO
const init_speed: int = 600
var speed: int = 600
var max_speed := 1000
var max_scale := 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = init_speed # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	target_velocity = Vector2.ZERO
	
	if Input.is_action_pressed("Player A LEFT"):
		target_velocity += Vector2.LEFT * speed
	
	if Input.is_action_pressed("Player A RIGHT"):
		target_velocity += Vector2.RIGHT * speed

	velocity = lerp(velocity, target_velocity, delta*10)
	var _collision = move_and_collide(velocity*delta)
#	if collision:
#		print(collision)

func inc_speed():
	if speed < max_speed:
		speed += 100

func grow():
	if scale.x < max_scale:
		scale.x *= 1.1


func reset():
	speed = init_speed
	scale = Vector2(1, 1)
