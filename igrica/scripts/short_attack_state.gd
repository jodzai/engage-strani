extends State

@onready var attack_start_timer = $"../../attack_start_timer"
@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var hurtbox_left = $"../../hurtbox_left"
@onready var collision_shape_left = $"../../hurtbox_left/CollisionShape2D"

@onready var hurtbox_right = $"../../hurtbox_right"
@onready var collision_shape_right = $"../../hurtbox_right/CollisionShape2D"


@export var follow_state: State
@export var turn_state: State

var parent: Boss
var player: CharacterBody2D

var attack_anim_ended = false
var attack_hit = false

func enter() -> void:
	$"../../Label".text = "SHORT ATTACK!!!"
	
	animated_sprite.play("short_attack")
	if follow_state.start_dir.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
	attack_hit = false
	attack_anim_ended = false
	parent.velocity = Vector2.ZERO

func exit() -> void:
	
	var rand = randf_range(1.0, 2.0)
	attack_start_timer.start(rand)

func process_frame(_delta: float) -> State:
	if attack_anim_ended:
		var curr_dir = parent.global_position.direction_to(player.global_position)
		curr_dir.y = 0
		curr_dir = curr_dir.normalized()
		if curr_dir.x * follow_state.start_dir.x < 0:
			return turn_state
		return follow_state
	#Ovde se menjaju frejmovi na kojima se udaraju
	if animated_sprite.frame > 4 and animated_sprite.frame < 10:
		if follow_state.start_dir.x > 0:
			collision_shape_right.disabled = false
			if hurtbox_right.get_overlapping_bodies():
				attack_hit = true
		else:
			collision_shape_left.disabled = false
			if hurtbox_left.get_overlapping_bodies():
				attack_hit = true
	else: 
		collision_shape_left.disabled = true
		collision_shape_right.disabled = true
	return null


func _on_animated_sprite_2d_animation_finished():
	attack_anim_ended = true
