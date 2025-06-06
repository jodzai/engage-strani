extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0
@onready var sprite: AnimatedSprite2D = $sprite
@onready var stamina_bar: ProgressBar = $"../CanvasLayer/stamina_bar"

var vulnerable=true
var is_dashing=false
var dash_time = 0.2
var dash_speed = 1000.0
var stamina_refresh=0.5
@onready var sekundara: Timer = $sekundara
@onready var dash_timer: Timer = $dash_timer

var stamina : int = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta
	
	if is_dashing:
		if not sprite.flip_h:
			velocity.x=dash_speed
		elif sprite.flip_h:
			velocity.x=-dash_speed
	
			
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_dashing:
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("dash"):
		dash()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
		
	if direction and not is_dashing:
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
	
func dash():
	if not is_dashing and stamina>=30:
		sekundara.stop()
		stamina-=30
		if stamina<0:
			stamina=0
		velocity.y=0
		sprite.modulate = Color(1, 1, 1, 0.5)
		vulnerable=false
		is_dashing=true
		dash_timer.start(dash_time)
		
	


func _on_dash_timer_timeout() -> void:
	vulnerable=true
	is_dashing = false
	sprite.modulate = Color(1, 1, 1, 1)
	sekundara.start(stamina_refresh)

	
func _process(delta: float) -> void:
	stamina_bar.value=stamina
	
		
		

func _ready() -> void:
	sekundara.start(stamina_refresh)
	
func _on_sekundara_timeout() -> void:
	if(stamina<100):
		stamina+=5 
