extends State

@onready var attack_start_timer = $"../../attack_start_timer"
@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var animation_player = $"../../AnimationPlayer"
@onready var thunder_hitboxes_left = $"../../thunder_hitboxes_left"

@export var follow_state: State
@export var idle_state: State
var hitbox_is_flipped : bool = false
var parent: Boss
var player: CharacterBody2D

var attack_anim_ended = false

func enter() -> void:
	$"../../Label".text = "BIIIG BOOOIII!!!"
	
	animated_sprite.play("demon_tunder")
	
	animation_player.play("new_animation")
	
	if follow_state.curr_dir.x > 0:
		animated_sprite.flip_h = true
		
	else:
		animated_sprite.flip_h = false
	
	attack_anim_ended = false

func exit() -> void:
	var rand = randf_range(parent.attack_timer_min, parent.attack_timer_max)
	attack_start_timer.start(rand)
	if animated_sprite.flip_h:
		for child in thunder_hitboxes_left.get_children():
			child.position.x = child.position.x * -1

func process_frame(_delta: float) -> State:
	parent.velocity -= parent.velocity * 0.2
	if animated_sprite.flip_h and not hitbox_is_flipped:
		hitbox_is_flipped = true
		for child in thunder_hitboxes_left.get_children():
			child.position.x = -child.position.x
			
	if not animated_sprite.flip_h and hitbox_is_flipped:
		hitbox_is_flipped = true
		for child in thunder_hitboxes_left.get_children():
			child.position.x = child.position.x
			
	if attack_anim_ended:
		return idle_state
	return null

func _on_animated_sprite_2d_animation_finished():
	attack_anim_ended = true

func _process(delta):
	if animated_sprite.flip_h == false:
		hitbox_is_flipped = false
