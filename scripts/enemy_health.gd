extends Node

@export var max_health: int = 100
var health: int

func _ready():
	health = max_health
	print(health)
	
	
