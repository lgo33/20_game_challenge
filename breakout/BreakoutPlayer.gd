extends CharacterBody2D
class_name BOPlayer

var target_velocity: Vector2 = Vector2.ZERO
const init_speed: int = 600
var speed: int = 600
var max_speed := 1000
var max_scale := 2.0

@onready var label: Label = $Label
@onready var label_timer: Timer = $LabelTimer

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

	velocity = lerp(velocity, target_velocity, delta*15)
	var _collision = move_and_collide(velocity*delta)
#	if collision:
#		print(collision)

func set_label(text) -> void:
	label.text = text
	label.visible = true
	label_timer.start()

func inc_speed():
	if speed < max_speed:
		set_label("+Speed+")
		speed += 100

func grow():
	if scale.x < max_scale:
		set_label("+LEN+")
		scale.x *= 1.1

func reset():
	speed = init_speed
	scale = Vector2(1, 1)

func _on_label_timer_timeout() -> void:
	label.visible = false
