extends State

@onready var timer = $"../../wake_up_timer"

@export var follow_state: State

var parent: Boss
var player: CharacterBody2D

var wake_up_timer_ended = false

func enter() -> void:
	$"../../Label".text = "Waking_up"
	timer.start()
	wake_up_timer_ended = false

func process_frame(_delta: float) -> State:
	if wake_up_timer_ended:
		return follow_state
	return null

func _on_timer_timeout():
	wake_up_timer_ended = true
