extends State

@onready var turning_timer = $"../../turning_timer"

@export var follow_state: State

var parent: Boss
var player: CharacterBody2D

var turn_timer_ended: bool = false

func enter() -> void:
	$"../../Label".text = "Turning"
	parent.velocity = Vector2.ZERO
	turning_timer.start()
	turn_timer_ended = false

func process_frame(delta: float) -> State:
	if turn_timer_ended:
		return follow_state
	return null


func _on_turning_timer_timeout():
	turn_timer_ended = true
