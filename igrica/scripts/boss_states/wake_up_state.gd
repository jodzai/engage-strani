extends State

@onready var animated_sprite = $"../../AnimatedSprite2D"

@export var follow_state: State

var parent: Boss
var player: CharacterBody2D

var wake_up_anim_ended = false

func enter() -> void:
	$"../../Label".text = "Waking_up"
	animated_sprite.play("wake_up")
	wake_up_anim_ended = false

func process_frame(_delta: float) -> State:
	if wake_up_anim_ended:
		return follow_state
	return null


func _on_animated_sprite_2d_animation_finished():
	wake_up_anim_ended = true
