extends StaticBody2D

signal scored_signal()

var speed := 450
var scored := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
#	init() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed * delta
	if position.x < -100:
		queue_free()
		
	if position.x < 100 and scored == false:
		scored = true
		scored_signal.emit()

func init():
	position.x = 1200
	position.y = 648

