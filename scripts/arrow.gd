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

var target: Node2D
var speed: float = 300.0


func _process(delta: float) -> void:
	if target:
		var direction = global_position.direction_to(target.global_position)
		global_position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body == target:
		queue_free()
