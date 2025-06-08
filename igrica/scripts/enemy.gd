class_name Enemy
extends RewindableCharacter

var direction=1

var timer_value: float = 0
var old_direction: int = 1

@onready var lr_timer: Timer = $lr_timer

func _physics_process(delta: float) -> void:
	if can_move:
		velocity.x=100*direction
	
	move_and_slide()

func begin_snapshot() -> void:
	old_direction = direction
	timer_value = lr_timer.time_left

func pre_rewind() -> void:
	lr_timer.paused = true

func end_rewind() -> void:
	direction = old_direction
	lr_timer.paused = false
	lr_timer.start(timer_value)

func _on_ready() -> void:
	lr_timer.start(2)

func _on_lr_timer_timeout() -> void:
	lr_timer.start(2)
	direction*=-1
