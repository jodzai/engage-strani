extends State

@onready var attack_start_timer = $"../../attack_start_timer"
@onready var animated_sprite = $"../../AnimatedSprite2D"

@export var follow_state: State

var parent: Boss
var player: CharacterBody2D

var attack_anim_ended = false
var bullet_spawned = false

func enter() -> void:
	$"../../Label".text = "LONG ATTACK!!!"
	
	animated_sprite.play("long_attack")
	if follow_state.start_dir.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
	attack_anim_ended = false
	bullet_spawned = false
	parent.velocity = Vector2.ZERO

func exit() -> void:
	var rand = randf_range(1.0, 2.0)
	attack_start_timer.start(rand)

func process_frame(_delta: float) -> State:
	if attack_anim_ended:
		return follow_state
		
		
	return null


func _on_animated_sprite_2d_animation_finished():
	attack_anim_ended = true
