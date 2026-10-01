class_name MovementComponent
extends Node2D

signal reached_end

var base_speed: float = 0.0
var direction: Vector2 = Vector2.RIGHT

var end_x: float = INF
var is_active: bool = true

@onready var body: Node2D = get_parent()

func setup(speed: float, goal_x: float = INF) -> void:
	base_speed = speed
	end_x = goal_x
	is_active = true 

func _process(delta: float) -> void:
	if not is_active:
		return
	body.position += direction * base_speed * delta
	if body.position.x >= end_x:
		is_active = false
		reached_end.emit()

# Possible functions later on for pause can also link to some buttons 
func stop() -> void:
	is_active = false

func resume() -> void:
	is_active = true 
