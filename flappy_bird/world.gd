extends Node2D

var RockUp: PackedScene = preload("res://flappy_bird/rock_up.tscn")
var num_rock := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed('quit'):
		get_tree().quit() 

func _on_obstacle_timer_timeout() -> void:
	var rock := RockUp.instantiate()
	if (num_rock % 2):
		rock.position.y = 0
		rock.scale.y = -1
	else:
		rock.position.y = 648
	rock.scale.y *= randf_range(0.5, 1.5)
	num_rock += 1
	rock.position.x = 1200
	$RocksContainer.add_child(rock)
