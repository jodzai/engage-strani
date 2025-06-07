class_name Boss
extends CharacterBody2D

@onready var state_machine = $State_machine

@export var player: CharacterBody2D
@export var speed = 100
@export var attack_change_len = 75.0

func _ready():
	state_machine.init(self, player)

func _process(delta):
	state_machine.process_frame(delta)

func _physics_process(delta):
	state_machine.process_physics(delta)
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
