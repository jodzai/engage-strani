extends State

@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var idle_timer = $"../../idle_timer"

@export var follow_state: State
@export var transition: State

var parent: Boss
var player: CharacterBody2D

var idle_time: float = 1
var idle_timer_ended = false

func enter() -> void:
	$"../../Label".text = "Idle"
	animated_sprite.play("Idle")
	idle_timer.start(idle_time)
	idle_timer_ended = false

func process_frame(_delta: float) -> State:
	if parent.second_faze:
		return transition
	if idle_timer_ended:
		return follow_state
	return null

func _on_idle_timer_timeout():
	idle_timer_ended = true
