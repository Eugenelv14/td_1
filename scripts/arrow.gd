#extends Area2D
#
#@onready var arrow: Area2D = $"."
#
#var target
#
#
#
#
#var speed: float = -300.0
#
#func _process(delta):
	#position.x += speed * delta
	#
	#if position.x < -500:
		#queue_free()
extends Area2D

@export var arrow_damage: int = 7
var target: Node2D
var speed: float = 300.0


func _process(delta: float) -> void:
	if not is_instance_valid(target):
		queue_free()
		return

	var direction = global_position.direction_to(target.global_position)
	rotation = direction.angle()
	global_position += direction * speed * delta
