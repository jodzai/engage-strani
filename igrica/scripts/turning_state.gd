extends State

@onready var animated_sprite = $"../../AnimatedSprite2D"

@export var follow_state: State

var parent: Boss
var player: CharacterBody2D

var turn_anim_ended: bool = false

func enter() -> void:
	$"../../Label".text = "Turning"
	animated_sprite.play("turning")
	if follow_state.start_dir.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
	turn_anim_ended = false

func process_frame(delta: float) -> State:
	parent.velocity -= parent.velocity * 0.2
	if turn_anim_ended:
		return follow_state
	return null


func _on_animated_sprite_2d_animation_finished():
	turn_anim_ended = true
