extends CharacterBody2D

@export var init_speed := 400
var speed := init_speed

func _ready() -> void:
	init()
	
func _physics_process(delta: float) -> void:
#	velocity = direction * speed
	var collision = move_and_collide(velocity*delta, false, 0.01, false)
	if collision: 
#		short_blip_sound.play()
		var collider = collision.get_collider()
		if collider is Brick:
			collider.destroy()
		velocity = velocity.bounce(collision.get_normal())

func init() -> void:
	speed = init_speed
	position = Vector2(600, 500)
	velocity = Vector2(randf_range(-100, 100), -100).normalized() * speed
