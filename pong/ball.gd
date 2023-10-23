extends CharacterBody2D

var speed: int = 400
var rng = RandomNumberGenerator.new()
var direction: Vector2 = Vector2.ZERO

@onready var short_blip_sound: AudioStreamPlayer = $ShortBlipSound

# Called when the node enters the scene tree for the first time.
func _ready():
	init()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#	velocity = direction * speed
	var collision = move_and_collide(velocity*delta)
	if collision: 
		short_blip_sound.play()
		var collider = collision.get_collider()
		if collider is CharacterBody2D:
			velocity.y += collider.velocity.y / 3
		velocity = velocity.bounce(collision.get_normal())
		
func init():
	position.x = 600
	position.y = 300
	direction = Vector2.LEFT * (rng.randi_range(0, 1) - 0.5) * 2 + Vector2.UP * rng.randf_range(-1, 1)
	velocity = direction.normalized() * speed
	rng.randf()
