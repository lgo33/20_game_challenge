extends CharacterBody2D

@export var init_speed := 400
@export var ball_scale := 0.5
var speed := init_speed
@onready var blip: AudioStreamPlayer2D = $blip

func _ready() -> void:
	init()
	
func _physics_process(delta: float) -> void:
#	velocity = direction * speed
	var collision = move_and_collide(velocity*delta, false, 0.01, false)
	if collision: 
		blip.play()
		var collider = collision.get_collider()
		if collider is Brick:
			collider.destroy()
		if velocity.y > 0 or not collider is CharacterBody2D:
			velocity = velocity.bounce(collision.get_normal())

func init() -> void:
	speed = init_speed
	scale = Vector2(ball_scale, ball_scale)
	position = Vector2(600, 500)
	velocity = Vector2(randf_range(-100, 100), -100).normalized() * speed
