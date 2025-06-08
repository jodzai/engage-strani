extends State

@onready var animated_sprite = $"../../AnimatedSprite2D"

@export var follow_state: State

var parent: Boss
var player: CharacterBody2D

var transition_anim_ended = false

func enter() -> void:
	$"../../Label".text = "Transition"
	animated_sprite.play("wake_up")
	transition_anim_ended = false
	parent.second_faze = false
	parent.power_up()
	

func process_frame(_delta: float) -> State:
	parent.velocity -= parent.velocity * 0.2
	if transition_anim_ended:
		return follow_state
	return null


func _on_animated_sprite_2d_animation_finished():
	transition_anim_ended = true
