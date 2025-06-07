extends CharacterBody2D
var direction=1
@onready var lr_timer: Timer = $lr_timer

func _physics_process(delta: float) -> void:
	velocity.x=100*direction
	
	move_and_slide()
	



func _on_ready() -> void:
	lr_timer.start(2)

func _on_lr_timer_timeout() -> void:
	direction*=-1
