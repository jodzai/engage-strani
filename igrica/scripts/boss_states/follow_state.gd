extends State

@onready var attack_start_timer = $"../../attack_start_timer"
@onready var animated_sprite = $"../../AnimatedSprite2D"

@export var short_attack_state: State
@export var long_attack_state: State
@export var transition: State
@export var big_attack_state: State
@export var upper_laser_state: State

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
	if parent.big_attack_able:
		animated_sprite.play("demon_idle")
	else:
		animated_sprite.play("walking")
	if start_dir.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
	attack_start_timer_ended = false

func process_physics(delta:float) -> State:
	curr_dir = player.global_position - parent.global_position
	curr_dir.y = 0
	curr_dir = curr_dir.normalized()
	
	if parent.second_faze:
		return transition
	
	if curr_dir.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	#Ako biva preskočen onda treba da se okrene
	#nema veze :(
	#Prvi put kad anailazi na igrača biće šort atack
	if abs(parent.global_position.x - player.global_position.x) < parent.attack_change_len and !player_entered_zone:
		player_entered_zone = true
		attack_start_timer.start()
		return short_attack_state
	
	#Svaki sledeći napad se određuje ovde
	if player_entered_zone and attack_start_timer_ended:
		if abs(parent.global_position.x - player.global_position.x) < parent.attack_change_len:
			if parent.big_attack_able:
				if abs(parent.global_position.y - player.global_position.y) > 60:
					return upper_laser_state
				else:
					return short_attack_state
			else:
				return short_attack_state
		else:
			if parent.big_attack_able:
				var rand = randf()
				if rand > 0.5:
					if abs(parent.global_position.y - player.global_position.y) > 60:
						return upper_laser_state
					else:
						return long_attack_state
				else:
					return big_attack_state
			else:
				return long_attack_state
	
	#dodajem deo koji će da uspori bossa tako da ne bi poludeo oko playera
	#min distanca pomeranja
	if abs(parent.global_position.x - player.global_position.x) > 50:
		parent.velocity = curr_dir.normalized() * abs(parent.global_position-player.global_position)/parent.speed * delta * 100
	else:
		parent.velocity -= parent.velocity*0.2
	return null


func _on_attack_start_timer_timeout():
	attack_start_timer_ended = true
