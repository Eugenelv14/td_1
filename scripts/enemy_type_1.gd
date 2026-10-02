extends CharacterBody2D

const speed = 60

var direction = 1
@onready var ray_cast_right: RayCast2D = $RayCastRight

func _process(delta):
	
	if ray_cast_right.is_colliding():
		print("Wall is being attacked")
	
	position.x += direction * speed * delta
	
	
