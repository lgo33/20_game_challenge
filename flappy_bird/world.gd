extends Node2D

var RockUp: PackedScene = preload("res://flappy_bird/rock_up.tscn")
var num_rock := 0
var rock_height := 239
var score := 0:
	set(val):
		$ScoreLabel.text = str(val)
		score = val

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed('quit'):
		get_tree().quit() 

func _on_obstacle_timer_timeout() -> void:
	var rock_up := RockUp.instantiate()
	var rock_down := RockUp.instantiate()
	rock_down.position.y = -10
	rock_up.position.y = 660
	var gap := randf_range(-0.6, 0.6)
	rock_up.scale.y = 1 + gap
	
	rock_down.scale.y = -(1 - gap)
	
	rock_up.position.x = 1200
	rock_down.position.x = 1200
	
	rock_up.scored_signal.connect(scored_rock)
	
	$RocksContainer.add_child(rock_up)
	$RocksContainer.add_child(rock_down)
	
func scored_rock():
	score += 1


func _on_plane_crashed(collision) -> void:
	get_tree().paused = true # Replace with function body.
	$CrashedLabel.visible = true



