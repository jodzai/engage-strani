extends State

@onready var attack_start_timer = $"../../attack_start_timer"
@onready var animated_sprite = $"../../AnimatedSprite2D"

@export var follow_state: State
@export var idle_state: State

var parent: Boss
var player: CharacterBody2D

var attack_anim_ended = false

func enter() -> void:
	$"../../Label".text = "BIIIG BOOOIII!!!"
	
	animated_sprite.play("long_attack")
	if follow_state.curr_dir.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
	attack_anim_ended = false

func exit() -> void:
	var rand = randf_range(parent.attack_timer_min, parent.attack_timer_max)
	attack_start_timer.start(rand)

func process_frame(_delta: float) -> State:
	parent.velocity -= parent.velocity * 0.2
	if attack_anim_ended:
		return idle_state
		
	return null

func _on_animated_sprite_2d_animation_finished():
	attack_anim_ended = true
