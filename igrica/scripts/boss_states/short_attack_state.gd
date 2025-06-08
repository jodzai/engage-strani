extends State

@onready var attack_start_timer = $"../../attack_start_timer"
@onready var animated_sprite = $"../../AnimatedSprite2D"

@onready var hurtbox_left = $"../../hurtbox_left"
@onready var collision_shape_left = $"../../hurtbox_left/CollisionShape2D"

@onready var hurtbox_right = $"../../hurtbox_right"
@onready var collision_shape_right = $"../../hurtbox_right/CollisionShape2D"


@export var follow_state: State
@export var idle_state: State
@export var transition: State
@export var repost_state: State

var parent: Boss
var player: CharacterBody2D

var attack_anim_ended = false
var attack_hit = false

func enter() -> void:
	$"../../Label".text = "SHORT ATTACK!!!"
	if parent.big_attack_able:
		animated_sprite.play("demon_short_attack")
	else:
		animated_sprite.play("short_attack")
	if follow_state.curr_dir.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
	attack_hit = false
	attack_anim_ended = false

func exit() -> void:
	if !attack_hit:
		var rand = randf_range(parent.attack_timer_min, parent.attack_timer_max)
		attack_start_timer.start(rand)

func process_frame(_delta: float) -> State:
	if parent.second_faze:
		return transition
	
	parent.velocity -= parent.velocity * 0.2
	if attack_anim_ended:
		if attack_hit:
			return repost_state
		return idle_state
	#Ovde se menjaju frejmovi na kojima se udaraju
	if animated_sprite.frame == 6:
		if follow_state.curr_dir.x > 0:
			collision_shape_right.disabled = false
			var targets = hurtbox_right.get_overlapping_bodies()
			if targets:
				attack_hit = true
				for target in targets:
					if target.has_method("take_damage"):
						target.take_damage()
		else:
			collision_shape_left.disabled = false
			var targets = hurtbox_left.get_overlapping_bodies()
			if targets:
				attack_hit = true
				for target in targets:
					if target.has_method("take_damage"):
						target.take_damage()
	else: 
		collision_shape_left.disabled = true
		collision_shape_right.disabled = true
	return null

func _on_animated_sprite_2d_animation_finished():
	attack_anim_ended = true
