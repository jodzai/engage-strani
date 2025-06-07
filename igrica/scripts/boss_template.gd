class_name Boss
extends CharacterBody2D

@onready var state_machine = $State_machine

@export var player: CharacterBody2D
@export var speed = 100
@export var attack_change_len = 75.0
@export var health: int = 3

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
