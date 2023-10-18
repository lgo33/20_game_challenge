extends Node2D

@onready var ball = $Ball

var scoreA:int = 0
var scoreB:int = 0
@onready var label_A: Label = $LabelA
@onready var label_B: Label = $LabelB
@onready var hurt_sound: AudioStreamPlayer = $HurtSound

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	
	if ball.position.x < 0:
		scoreB += 1
		label_B.text = str(scoreB)
		ball.init()
		hurt_sound.play()
	
	if ball.position.x > 1200:
		scoreA += 1
		label_A.text = str(scoreA)
		ball.init()
		hurt_sound.play()

	
func print_score():
	printt(scoreA, scoreB)
