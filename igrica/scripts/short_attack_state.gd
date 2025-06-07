extends State

@onready var attack_start_timer = $"../../attack_start_timer"
@onready var attack_len_timer = $"../../attack_len_timer"

@export var follow_state: State

var parent: Boss
var player: CharacterBody2D

var attack_len_timer_ended = false

func enter() -> void:
	$"../../Label".text = "SHORT ATTACK!!!"
	attack_len_timer_ended = false
	attack_len_timer.start()
	parent.velocity = Vector2.ZERO

func exit() -> void:
	var rand = randf_range(1.0, 2.0)
	attack_start_timer.start(rand)

func process_frame(_delta: float) -> State:
	if attack_len_timer_ended:
		return follow_state
	return null


func _on_attack_len_timer_timeout():
	attack_len_timer_ended = true
