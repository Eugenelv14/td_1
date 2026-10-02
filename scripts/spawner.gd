class_name Spawner
extends Node2D

signal wave_started(wave_number: int, total_waves:int)
signal wave_cleared(wave_number:int)
signal all_waves_completed
signal enemy_removed

#Loads Data and enemy
@export var enemy_scene: PackedScene
@export var enemy_pool: Array[EnemyData]
@export var enemy_container: Node

@export_group("Waves")
@export var total_waves: int = 5
@export var enemie_per_wave: int = 5
@export var enemies_added_per_wave: int = 0

@export_group("Timing")
@export var initial_countdown: float = 5.0
@export var time_between_waves: float = 3.0
@export var spawn_interval: float = 0.3
@export var auto_start: bool = true 

@onready var spawn_point: Marker2D = $SpawnPoint
@onready var goal_point: Marker2D = $GoalPoint

var current_wave: int = 0
var alive_enemies: int = 0
var is_running: bool = false

func _ready() -> void:
	if auto_start:
		start()

func start() -> void:
	#Stops next wave from running if a current wave is happening
	if is_running:
		return
	
	#Wave starts from here
	assert(enemy_scene != null, "Spawner needs an enemy scene")
	assert(not enemy_pool.is_empty(), "Spawner needs at least one EnemyData")
	is_running = true
	
	#Waits for countdown 
	await _wait(initial_countdown)
	
	#Starts loop for spawning waves
	for wave in range(1, total_waves + 1):
		current_wave = wave
		await _run_wave()
	
	
func _run_wave() -> void:
	var enemy_count := enemie_per_wave + enemies_added_per_wave * (current_wave - 1)
	wave_started.emit(current_wave, total_waves)
	
	for i in enemy_count:
		_spawn_enemy()
		if spawn_interval > 0.0 and i < enemy_count - 1:
			await _wait(spawn_interval)
			
	#By this point everything should be spawned, now it waits till the last enemy is dead
	while alive_enemies > 0:
		await enemy_removed 
		
	wave_cleared.emit(current_wave)
	
	
func _spawn_enemy() -> void:
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.data = enemy_pool.pick_random()
	enemy.goal_x = goal_point.global_position.x
	enemy.killed.connect(_on_enemy_gone)
	enemy.reached_goal.connect(_on_enemy_gone)
	alive_enemies += 1
	
	var parent: Node = enemy_container if enemy_container else self
	parent.add_child(enemy)
	enemy.global_position = spawn_point.global_position

func _on_enemy_gone() -> void:
	alive_enemies -= 1
	enemy_removed.emit()

func _wait(seconds: float) -> void:
	if seconds > 0.0:
		await get_tree().create_timer(seconds).timeout
