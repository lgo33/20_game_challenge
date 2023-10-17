extends Node2D

@onready var ball = $Ball

var scoreA:int = 0
var scoreB:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	
	if ball.position.x < 0:
		scoreB += 1
		ball.init()
		print_score()
	
	if ball.position.x > 1200:
		scoreA += 1
		ball.init()
		print_score()

	
func print_score():
	printt(scoreA, scoreB)
