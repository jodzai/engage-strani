extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var health = 3

var damage_taken = false

@onready var sprite: AnimatedSprite2D = $sprite

@onready var stamina_bar: ProgressBar = $"../CanvasLayer/stamina_bar"
@onready var freeze_timer: Timer = $freeze_timer
@onready var freeze_cd_label: Label = $"../CanvasLayer/freeze_cd_label"
@onready var invic_timer = $Invic_timer



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		sprite.play('run')
		velocity.x = direction * SPEED
	else:
		sprite.play('idle')
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	move_and_slide()

func take_damage():
	if !damage_taken:
		health -= 1
		damage_taken = true
		invic_timer.start()
		print("HIT!!")



func _on_invic_timer_timeout():
	damage_taken = false
