extends CharacterBody2D


var speed : float = 150.0
var jump_velocity : float = -300.0
@export var health =5
@onready var sprite: AnimatedSprite2D = $sprite
@onready var hurtbox_container: Area2D = $hurtbox_container
@onready var hurtbox: CollisionShape2D = $hurtbox_container/hurtbox
var vulnerable : bool = true
var invincibility_duration : float = 1.5

@onready var i_frame_timer: Timer = $timers/i_frame_timer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custowm gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction: 
		velocity.x = direction * speed
		sprite.play('run')
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		sprite.play('idle')
	if velocity.x>0:
		sprite.flip_h=false
	elif velocity.x<0:
		sprite.flip_h=true
	move_and_slide()

func take_damage(amount):
	if vulnerable:	
		vulnerable=false
		sprite.self_modulate = "ffffff79"
		i_frame_timer.start()
		health-=amount
		print('Damage taken. Remaining health: ' + str(health))
		check_death()
		pass
	
func check_death():
	if health<=0:
		get_tree().reload_current_scene()


func _ready() -> void:
	hurtbox_container.collision_layer=4
	hurtbox_container.collision_mask=3

func _on_hurtbox_container_area_entered(area: Area2D) -> void:
	take_damage(1)


func _on_i_frame_timer_timeout() -> void:
	vulnerable=true
	sprite.self_modulate = "ffffff"



		
