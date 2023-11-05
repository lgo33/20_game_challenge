extends StaticBody2D
class_name Brick

var value := 100
var hit_points := 1
var call_back = null

signal destroyed()
signal xball()
signal fast_paddle()
signal grow_paddle()

@onready var polygon_2d: Polygon2D = $Polygon2D

enum BTYPE {XBALL, FAST_PADDLE, GROW, NORMAL}

# configure: color, value, probability
var brick_config = {
	BTYPE.XBALL : [Color.RED, 200, 0.1, xball],
	BTYPE.FAST_PADDLE : [Color.BLUE, 200, 0.1, fast_paddle],
	BTYPE.GROW : [Color.GREEN, 200, 0.1, grow_paddle],
	BTYPE.NORMAL : [Color.WHITE, 100, 1, null],
}

func _ready() -> void:
	pass

func hit() -> void:
	hit_points -= 1
	if hit_points <= 0:
		$CollisionPolygon2D.disabled = true
		destroyed.emit(value)
		if call_back != null:
			call_back.emit()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(0.2, 0.2), 0.3)
		tween.parallel().tween_property(self, "modulate:a", 0., 0.3)
		tween.tween_callback(queue_free)

func get_shape() -> Vector2:
	var _minx := 0.0
	var _maxx := 0.0
	var _miny := 0.0
	var _maxy := 0.0
	for pos in polygon_2d.polygon:
		if pos.x < _minx:
			_minx = pos.x
		elif pos.x > _maxx:
			_maxx = pos.x
			
		if pos.y < _miny:
			_miny = pos.y
		elif pos.y > _maxy:
			_maxy = pos.y
	return Vector2(_maxx - _minx, _maxy - _miny)
	
func set_type(brick_type: BTYPE = BTYPE.NORMAL) -> Brick:
	var cfg = brick_config[brick_type]
	var bcolor: Color = cfg[0]
	var bvalue: int = cfg[1] 
	self.call_back = cfg[3]
	self.modulate = bcolor
	self.value = bvalue
	return self
	
func set_rand_type() -> Brick:
	return set_type(get_rand_type())
	
func get_rand_type() -> BTYPE:
	var f: float = randf()
	for btype in brick_config:
		var prob: float = brick_config[btype][2]
		if f < prob:
			return btype
		else:
			f -= prob
	return BTYPE.NORMAL
