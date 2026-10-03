#extends Node2D
#
#@export var arrow_scene: PackedScene
#
#@onready var arrow_spawn: Marker2D = $ArrowSpawn
#
#var enemy_target
#var arrow_speed = 100
#var tracking = false
#
#
#
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if tracking:
		#var current_enemy_pos = enemy_target.position
		#var direction = calc_direction(current_enemy_pos, arrow_spawn.position)
		#print(enemy_target.position)
#
#
#func _physics_process(delta: float) -> void:
	#pass
	#
#
#
#func _on_shoot_timer_timeout() -> void:
	#var arrow = arrow_scene.instantiate()
	#add_child(arrow)
	#
	#
#
#func _on_attack_range_body_entered(body: Node2D) -> void:
	#tracking = true
	#enemy_target = body
	#
	#
#
#func _on_attack_range_body_exited(body: Node2D) -> void:
	#tracking = false
	#
#func calc_direction(current_enemy_pos, arrow_spawn_point):
	#var direction = Vector2(current_enemy_pos - arrow_spawn_point)
	#direction = direction.normalized()
	#return direction
	
extends Node2D

@export var arrow_scene: PackedScene

@onready var arrow_spawn: Marker2D = $ArrowSpawn

var enemy_target: Node2D


func _on_shoot_timer_timeout() -> void:
	if enemy_target:
		var arrow = arrow_scene.instantiate()
		add_child(arrow)

		arrow.global_position = arrow_spawn.global_position
		arrow.target = enemy_target


func _on_attack_range_body_entered(body: Node2D) -> void:
	enemy_target = body


func _on_attack_range_body_exited(body: Node2D) -> void:
	if body == enemy_target:
		enemy_target = null
	
