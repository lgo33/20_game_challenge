extends Node2D

var Brick: PackedScene = preload("res://breakout/brick.tscn")
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
@onready var ball: CharacterBody2D = $BOBall
@onready var player: CharacterBody2D = $Player

@onready var score_label: Label = $ScoreLabel
@onready var life_label: Label = $LifeLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	put_bricks()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	if ball.position.y > get_viewport().get_visible_rect().size.y:
		ball_out()

func put_bricks():
	var next_pos := top_left.position
	
	for i in range(300):
		var new_brick = Brick.instantiate() as Brick
		$Bricks.add_child(new_brick)
		new_brick.scale = brick_size
		new_brick.destroyed.connect(_on_brick_destroyed, 4)
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

func ball_out():
	if lifes >= 1:
		lifes -= 1
		ball.init()
		ball.position.x = player.position.x

func _on_brick_destroyed(value):
	score += value
	ball.velocity *= 1.02
