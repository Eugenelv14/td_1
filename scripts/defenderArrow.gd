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

var enemies_in_range: Array[Node2D] = []


func _on_shoot_timer_timeout() -> void:
	var target := _pick_target()
	if target == null:
		return

	var arrow = arrow_scene.instantiate()
	arrow.target = target
	add_child(arrow)
	arrow.global_position = arrow_spawn.global_position


func _pick_target() -> Node2D:
	# Drop anything that was freed (killed) while in range
	enemies_in_range = enemies_in_range.filter(is_instance_valid)
	if enemies_in_range.is_empty():
		return null

	# Target the enemy furthest along the path (enemies walk left to right)
	var best: Node2D = enemies_in_range[0]
	for enemy in enemies_in_range:
		if enemy.global_position.x > best.global_position.x:
			best = enemy
	return best


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body not in enemies_in_range:
		enemies_in_range.append(body)


func _on_attack_range_body_exited(body: Node2D) -> void:
	enemies_in_range.erase(body)
