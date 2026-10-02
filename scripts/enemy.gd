class_name Enemy
extends CharacterBody2D

signal reached_goal(enemy: Enemy)
signal killed(enemy: Enemy)

@export var data: EnemyData

@onready var health: HealthComponent = $Health_Component
@onready var movement: MovementComponent = $Movement_Component

#The x coordinate will be set up by the spawner scene
var goal_x: float = INF 

func _ready() -> void:
	assert(data != null, "Enemy needs an EnemyData resource")
	health.setup(data.max_health)
	movement.setup(data.speed, goal_x)
	
	health.died.connect(_on_died)
	movement.reached_end.connect(_on_reached_end)

func _on_died() -> void:
	"Enemy was killed"
	movement.stop()
	killed.emit(self)
	queue_free()

func _on_reached_end() -> void:
	reached_goal.emit(self)
	print("The monsters destroyed your tower you lose!")
	queue_free()
