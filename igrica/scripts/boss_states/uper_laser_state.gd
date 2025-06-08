extends State

@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var attack_start_timer = $"../../attack_start_timer"

@export var follow_state: State
@export var idle_state: State

var parent: Boss
var player: RewindableCharacter

var attack_anim_ended: bool = false

func enter() -> void:
	$"../../Label".text = "UPPER_ATTACK!!"
	
	animated_sprite.play("demon_big_laser")
	if follow_state.curr_dir.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	attack_anim_ended = false

func exit() -> void:
	var rand = randf_range(parent.attack_timer_min, parent.attack_timer_max)
	attack_start_timer.start(rand)

func process_frame(_delta: float) -> State:
	if animated_sprite.frame == 4:
		if follow_state.curr_dir.x > 0:
			pass
		#	collision_laser_right.disabled = false
		#	var targets = laser_right.get_overlapping_bodies()
		#	for target in targets:
		#		if target.has_method("take_damage"):
		#			target.take_damage()
		else:
			pass
		#	collision_laser_left.disabled = false
		#	var targets = laser_left.get_overlapping_bodies()
		#	for target in targets:
		#		if target.has_method("take_damage"):
		#			target.take_damage()
	else:
		pass
	#	collision_laser_right.disabled = true
	#	collision_laser_left.disabled = true
	
	parent.velocity -= parent.velocity * 0.2
	if attack_anim_ended:
		return idle_state
	return null

func _on_animated_sprite_2d_animation_finished():
	attack_anim_ended = true
