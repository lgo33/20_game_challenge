extends CharacterBody2D

@export var init_speed := 400
@export var ball_scale := 0.5
var speed := init_speed
var max_speed := 1000
@onready var blip: AudioStreamPlayer2D = $blip
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var disable_collision_timer: Timer = $DisableCollisionTimer


func _ready() -> void:
	init()
	
func _physics_process(delta: float) -> void:
#	velocity = direction * speed
	var collision = move_and_collide(velocity*delta, false, 0.01, false)
	if collision: 
		blip.play()
		var collider = collision.get_collider()
		if collider is Brick:
			collider.hit()
		if velocity.y > 0 or not collider is CharacterBody2D:
			velocity = velocity.bounce(collision.get_normal())
			if collider is BOPlayer:
				var impact_parameter = collider.velocity.normalized().dot(collision.get_normal())
#				print(collider.velocity * impact_parameter)
				velocity += collider.velocity * impact_parameter * 2
				set_collision_mask_value(3, false)
				disable_collision_timer.start()

func init() -> void:
	speed = init_speed
	scale = Vector2(ball_scale, ball_scale)
	position = Vector2(600, 500)
	velocity = Vector2(randf_range(-100, 100), -100).normalized() * speed
	
func bumb_speed(factor):
	if velocity.length() < max_speed:
		velocity *= factor
	
func _on_disable_collision_timer_timeout() -> void:
	set_collision_mask_value(3, true)
