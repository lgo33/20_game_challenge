extends StaticBody2D
class_name Brick

var value := 100

signal destroyed()

@onready var polygon_2d: Polygon2D = $Polygon2D

func _ready() -> void:
	pass

func destroy() -> void:
	$CollisionPolygon2D.disabled = true
	destroyed.emit(value)
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
