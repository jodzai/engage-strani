extends State

@onready var attack_start_timer = $"../../attack_start_timer"
@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var hurtbox_left = $"../../hurtbox_left"
@onready var collision_shape_left = $"../../hurtbox_left/CollisionShape2D"
@onready var hurtbox_right = $"../../hurtbox_right"
@onready var collision_shape_right = $"../../hurtbox_right/CollisionShape2D"

@onready var hurtbox_left_demon = $"../../hurtbox_left_demon"
@onready var collision_shape_left_demon = $"../../hurtbox_left_demon/CollisionShape2D"

@onready var hurtbox_right_demon = $"../../hurtbox_right_demon"
@onready var collision_shape_right_demon = $"../../hurtbox_right_demon/CollisionShape2D"


@export var follow_state: State
@export var idle_state: State
@export var transition: State

var parent: Boss
var player: CharacterBody2D

var attack_anim_ended = false
var attack_hit = false

const SWING = preload("res://assets/Music/Swing.wav")
@onready var audio_stream_player_10: AudioStreamPlayer = $"../../AudioStreamPlayer10"


func enter() -> void:
	$"../../Label".text = "AGAIN!!!"
	

	if parent.big_attack_able:
		animated_sprite.play("demon_repost")
	else:
		animated_sprite.play("repost_attack")
	

	if follow_state.curr_dir.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
	attack_anim_ended = false
	attack_hit = false
	parent.velocity = Vector2.ZERO

func exit() -> void:
	var rand = randf_range(parent.attack_timer_min, parent.attack_timer_max)
	attack_start_timer.start(rand)

func process_frame(_delta: float) -> State:
	if parent.second_faze:
		return transition
	
	if attack_anim_ended:
		return idle_state
	
	if parent.big_attack_able:
		if animated_sprite.frame == 1:
			if follow_state.curr_dir.x > 0:
				collision_shape_right_demon.disabled = false
				var targets = hurtbox_right_demon.get_overlapping_bodies()
				if targets:
					attack_hit = true
					for target in targets:
						if target.has_method("take_damage"):
							target.take_damage()
			else:
				collision_shape_left_demon.disabled = false
				var targets = hurtbox_left_demon.get_overlapping_bodies()
				if targets:
					attack_hit = true
					for target in targets:
						if target.has_method("take_damage"):
							target.take_damage()
		else: 
			collision_shape_left_demon.disabled = true
			collision_shape_right_demon.disabled = true
	else:
		if animated_sprite.frame == 1:
			if follow_state.curr_dir.x > 0:
				collision_shape_right.disabled = false
				var targets = hurtbox_right.get_overlapping_bodies()
				for target in targets:
					if target.has_method("take_damage"):
						target.take_damage()
			else:
				collision_shape_left.disabled = false
				var targets = hurtbox_left.get_overlapping_bodies()
				for target in targets:
					if target.has_method("take_damage"):
						target.take_damage()
		else: 
			collision_shape_left.disabled = true
			collision_shape_right.disabled = true
	return null

func _on_animated_sprite_2d_animation_finished():
	attack_anim_ended = true
