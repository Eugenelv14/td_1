extends Area2D

@onready var arrow: Area2D = $"."

var speed: float = -300.0

func _process(delta):
	position.x += speed * delta
	
	if position.x < -500:
		queue_free()
