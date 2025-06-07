extends State

@onready var attack_start_timer = $"../../attack_start_timer"

@export var turning_state: State
@export var short_attack_state: State
@export var long_attack_state: State

var parent: Boss
var player: CharacterBody2D

var start_dir: Vector2 = Vector2.ZERO
var curr_dir: Vector2 = Vector2.ZERO
var player_entered_zone: bool = false

var attack_start_timer_ended = false

func enter() -> void:
	$"../../Label".text = "Following"
	start_dir = player.global_position - parent.global_position
	start_dir.y = 0
	start_dir = start_dir.normalized()
	attack_start_timer_ended = false

func process_physics(delta:float) -> State:
	curr_dir = player.global_position - parent.global_position
	curr_dir.y = 0
	curr_dir = curr_dir.normalized()
	
	#Ako biva preskočen onda treba da se okrene
	if curr_dir.x * start_dir.x < 0:
		return turning_state
	
	#Prvi put kad anailazi na igrača biće šort atack
	if parent.global_position.distance_to(player.global_position) < parent.attack_change_len and !player_entered_zone:
		player_entered_zone = true
		attack_start_timer.start()
		return short_attack_state
	
	#Svaki sledeći napad se određuje ovde
	if player_entered_zone and attack_start_timer_ended:
		if parent.global_position.distance_to(player.global_position) < parent.attack_change_len:
			return short_attack_state
		else:
			return long_attack_state
	
	parent.velocity = curr_dir.normalized() * parent.speed * delta * 100
	return null


func _on_attack_start_timer_timeout():
	attack_start_timer_ended = true
