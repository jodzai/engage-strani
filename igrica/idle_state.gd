extends State

@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var idle_timer = $"../../idle_timer"

@export var follow_state: State

var parent: Boss
var player: CharacterBody2D

var idle_timer_ended = false

func enter() -> void:
	$"../../Label".text = "Idle"
	animated_sprite.play("wake_up")
	idle_timer.start()
	idle_timer_ended = false

func process_frame(_delta: float) -> State:
	if idle_timer_ended:
		return follow_state
	return null

func _on_idle_timer_timeout():
	idle_timer_ended = true
