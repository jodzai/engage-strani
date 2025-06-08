class_name Boss
extends RewindableCharacter

@onready var state_machine = $State_machine
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var player: CharacterBody2D
@export var speed = 75
@export var attack_change_len = 80.0
@export var health: int = 3

var old_state: State = null
var old_animation = null
var old_frame = null

var attack_timer_min: float = 2.0
var attack_timer_max: float = 4.0

var second_faze: bool = false
var big_attack_able: bool = false

func _ready():
	state_machine.init(self, player)

func _process(delta):
	if Input.is_action_just_pressed("hurt_boss"):
		health -= 1
		print(health)
	if health == 0:
		second_faze = true
		health = 3
	if $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.position.x = 346
	else:
		$AnimatedSprite2D.position.x = 0
	state_machine.process_frame(delta)

func _physics_process(delta):
	state_machine.process_physics(delta)
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func power_up():
	big_attack_able = true
	speed = speed*2
	%idle_state.idle_time = %idle_state.idle_time / 2
	attack_timer_min = attack_timer_min / 2
	attack_timer_max = attack_timer_max / 2

func begin_snapshot():
	old_state = state_machine.current_state
	old_frame = animated_sprite_2d.frame
	pass

func pre_rewind():
	animated_sprite_2d.pause()
	pass

func end_rewind():
	state_machine.change_state(old_state)
	animated_sprite_2d.frame = old_frame
	animated_sprite_2d.play()
	pass
