extends Node2D

var Brick: PackedScene = preload("res://breakout/brick.tscn")
var Ball: PackedScene = preload("res://breakout/bo_ball.tscn")

var gap := 10.0
var brick_size := Vector2(1.2, 1.2)

var score: int = 0:
	set(val):
		score = val
		score_label.text = str(val)

var lifes: int = 3:
	set(val):
		lifes = val
		life_label.text = str(val)

@onready var top_left: Marker2D = $TopLeft
@onready var bottom_right: Marker2D = $BottomRight
@onready var player: CharacterBody2D = $Player
@onready var ball_container: Node = $BallContainer

@onready var score_label: Label = $ScoreLabel
@onready var life_label: Label = $LifeLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	put_bricks()
#	new_ball()
	print("ball out ", ball_container.get_child_count())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("Player A UP"):
		new_ball()	
		
	for ball in ball_container.get_children():
		if ball.position.y > get_viewport().get_visible_rect().size.y:
			ball.queue_free()
			
	check()

func put_bricks():
	var next_pos := top_left.position
	
	for i in range(300):
		var new_brick = Brick.instantiate() as Brick
		$Bricks.add_child(new_brick)
		new_brick.set_rand_type()
		new_brick.scale = brick_size
		new_brick.destroyed.connect(_on_brick_destroyed, 4)
		new_brick.xball.connect(_on_xball, 4)
		new_brick.fast_paddle.connect(_on_fast_paddle, 4)
		new_brick.grow_paddle.connect(_on_grow_paddle, 4)
#		new_brick.modulate = Color.RED
		var shape: Vector2 = new_brick.get_shape() * brick_size
		new_brick.position = next_pos + (shape/2.)
		if next_pos.x + shape.x + gap >= bottom_right.position.x:
			next_pos.y += shape.y + gap
			next_pos.x = top_left.position.x			
		else:
			next_pos.x += shape.x + gap
		if next_pos.y >= bottom_right.position.y:
			break	

func check():
	if ball_container.get_child_count() == 0:
		if lifes >= 1:
			lifes -= 1
			new_ball()
			player.reset()
	if $Bricks.get_child_count() == 0:
		put_bricks()

func new_ball():
	var ball := Ball.instantiate()
	ball_container.add_child(ball)
	ball.position.x = player.position.x
	ball.add_to_group("Balls")
	

func _on_brick_destroyed(value):
	score += value
	get_tree().call_group("Balls", "bumb_speed", 1.02)
#	ball.velocity *= 1.02

func _on_xball():
	new_ball()

func _on_fast_paddle():
	print('fast paddle')
	player.speed += 100
	
func _on_grow_paddle():
	print('grow paddle')
	player.scale.x *= 1.1
