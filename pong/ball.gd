extends CharacterBody2D

var speed: int = 400
var rng = RandomNumberGenerator.new()
var direction: Vector2 = Vector2.LEFT + Vector2.UP * rng.randf_range(-1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = direction * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var colide = move_and_slide()
	if colide: 
		pass
